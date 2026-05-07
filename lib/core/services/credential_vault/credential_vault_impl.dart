import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'credential_vault.dart';

class CredentialVaultImpl implements CredentialVault {
  // ── Storage keys ──────────────────────────────────────────────────────────
  static const _kProjectId = 'fcm_project_id';
  static const _kClientEmail = 'fcm_client_email';
  static const _kPrivateKey = 'fcm_private_key';
  static const _kInitialized = 'fcm_vault_initialized';

  // ── Secure storage instance ───────────────────────────────────────────────
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // ── init: run once on first launch ───────────────────────────────────────
  @override
  Future<void> init() async {
    try {
      final alreadyMigrated = await _storage.read(key: _kInitialized);
      if (alreadyMigrated == 'true') {
        log(
          'CredentialVault: already initialized, reading from secure storage.',
        );
        return;
      }

      final projectId = dotenv.env['FCM_PROJECT_ID'] ?? '';
      final clientEmail = dotenv.env['FCM_CLIENT_EMAIL'] ?? '';
      final privateKey = (dotenv.env['FCM_PRIVATE_KEY'] ?? '').replaceAll(
        r'\n',
        '\n',
      );

      if (projectId.isEmpty || clientEmail.isEmpty || privateKey.isEmpty) {
        throw Exception(
          'FCM credentials missing from .env. '
          'Ensure FCM_PROJECT_ID, FCM_CLIENT_EMAIL, and FCM_PRIVATE_KEY are set.',
        );
      }
      await Future.wait([
        _storage.write(key: _kProjectId, value: projectId),
        _storage.write(key: _kClientEmail, value: clientEmail),
        _storage.write(key: _kPrivateKey, value: privateKey),
        _storage.write(key: _kInitialized, value: 'true'),
      ]);

      log(
        'CredentialVault: credentials migrated to secure storage successfully.',
      );
    } catch (e) {
      log('CredentialVault.init error: $e');
      rethrow;
    }
  }

  @override
  Future<String?> get projectId => _storage.read(key: _kProjectId);

  @override
  Future<String?> get clientEmail => _storage.read(key: _kClientEmail);

  @override
  Future<String?> get privateKey => _storage.read(key: _kPrivateKey);
}
