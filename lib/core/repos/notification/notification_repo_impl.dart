import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../services/database/database_service.dart';
import '../../services/fcm/fcm_service.dart';
import '../../utils/backend_endpoints.dart';
import 'notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final FcmService _fcmService;
  final DatabaseService _databaseService;

  static const _newProductsTopic = 'new_products';

  const NotificationRepoImpl(this._fcmService, this._databaseService);

  @override
  Future<Either<Failure, void>> sendNewProductNotification({
    required String productName,
    required String productId,
    required String imageUrl,
    bool isFeatured = false,
  }) async {
    final title = isFeatured ? '⭐ منتج مميز جديد!' : '🍓 منتج جديد!';
    final body = '$productName متاح الآن. تفضّل بالاطلاع عليه!';

    // ── Step 1: Send FCM push to all subscribed customers ──────────────────
    final fcmResult = await _fcmService.sendToTopic(
      topic: _newProductsTopic,
      title: title,
      body: body,
      imageUrl: imageUrl,
      data: {
        'type': 'new_product',
        'product_id': productId,
        'image_url': imageUrl,
      },
    );

    if (fcmResult.isLeft()) return fcmResult;

    // ── Step 2: Persist notification to Firestore /notifications ───────────
    try {
      await _databaseService.addData(
        path: BackendEndpoints.notifications,
        data: {
          'title': title,
          'body': body,
          'image_url': imageUrl,
          'product_id': productId,
          'type': 'new_product',
          'created_at': Timestamp.now(),
          'is_read': false,
        },
      );

      log('✅ Notification record saved to Firestore for: $productName');
      return const Right(null);
    } catch (e) {
      log('Exception saving notification to Firestore: $e');
      return Left(ServerFailure('تم إرسال الإشعار لكن فشل حفظه.'));
    }
  }
}
