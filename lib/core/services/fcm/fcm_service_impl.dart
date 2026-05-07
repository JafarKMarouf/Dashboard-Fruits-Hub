import 'dart:convert';
import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../errors/failure.dart';
import '../../utils/constants.dart';
import '../credential_vault/credential_vault.dart';
import 'fcm_service.dart';

class FcmServiceImpl implements FcmService {
  final CredentialVault _vault;

  FcmServiceImpl(this._vault);

  // ── Endpoints ─────────────────────────────────────────────────────────────
  static const _tokenEndpoint = 'https://oauth2.googleapis.com/token';
  static const _fcmScope = 'https://www.googleapis.com/auth/firebase.messaging';
  static const _fcmBaseUrl = 'https://fcm.googleapis.com/v1/projects';

  // ── Step 1: build a signed JWT and exchange it for an access token ─────────
  Future<String> _getAccessToken() async {
    final email = await _vault.clientEmail;
    final privateKey = await _vault.privateKey;

    if (email == null || privateKey == null) {
      throw Exception('FCM credentials missing from secure storage.');
    }

    final now = DateTime.now();

    // Build JWT claim set per Google OAuth2 service-account spec
    final jwt = JWT({
      'iss': email,
      'sub': email,
      'aud': _tokenEndpoint,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': (now.millisecondsSinceEpoch ~/ 1000) + 3600,
      'scope': _fcmScope,
    });

    // Sign with RSA-256 using the service-account private key
    final signedJwt = jwt.sign(
      RSAPrivateKey(privateKey),
      algorithm: JWTAlgorithm.RS256,
    );

    final response = await http.post(
      Uri.parse(_tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': signedJwt,
      },
    );

    if (response.statusCode != 200) {
      log('FCM token error ${response.statusCode}: ${response.body}');
      throw Exception('Failed to obtain OAuth2 access token.');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['access_token'] as String;
  }

  // ── Step 2: call FCM HTTP v1 with the access token ─────────────────────────
  Future<Either<Failure, void>> _send(Map<String, dynamic> message) async {
    try {
      final accessToken = await _getAccessToken();
      final projectId = await _vault.projectId;

      if (projectId == null) {
        return Left(
          ServerFailure('FCM project ID not found in secure storage.'),
        );
      }

      final url = '$_fcmBaseUrl/$projectId/messages:send';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        log('✅ FCM message sent successfully.');
        return const Right(null);
      }

      log('❌ FCM HTTP error ${response.statusCode}: ${response.body}');
      return Left(ServerFailure('FCM send failed (${response.statusCode}).'));
    } catch (e) {
      log('Exception in FcmServiceImpl._send: $e');
      return Left(ServerFailure('Unexpected FCM error: $e'));
    }
  }

  // ── Public: send to topic ─────────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> sendToTopic({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  }) {
    return _send(
      _buildPayload(
        target: {'topic': topic},
        title: title,
        body: body,
        imageUrl: imageUrl,
        data: data,
      ),
    );
  }

  // ── Public: send to single device ─────────────────────────────────────────
  @override
  Future<Either<Failure, void>> sendToDevice({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  }) {
    return _send(
      _buildPayload(
        target: {'token': token},
        title: title,
        body: body,
        imageUrl: imageUrl,
        data: data,
      ),
    );
  }

  // ── Shared payload builder ─────────────────────────────────────────────────
  Map<String, dynamic> _buildPayload({
    required Map<String, String> target,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  }) {
    return {
      ...target,

      'notification': {
        'title': title,
        'body': body,
        if (imageUrl != null && imageUrl.isNotEmpty) 'image': imageUrl,
      },

      if (data != null && data.isNotEmpty) 'data': data,

      // Android-specific: high priority + channel + image
      'android': {
        'priority': 'high',
        'notification': {
          'channel_id': kFcmAndroidChannelId,
          if (imageUrl != null && imageUrl.isNotEmpty) 'image': imageUrl,
        },
      },

      // iOS-specific: badge + sound + image
      'apns': {
        'payload': {
          'aps': {'badge': 1, 'sound': 'default'},
        },
        if (imageUrl != null && imageUrl.isNotEmpty)
          'fcm_options': {'image': imageUrl},
      },
    };
  }
}
