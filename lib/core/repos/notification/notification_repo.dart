import 'package:dartz/dartz.dart';
import '../../errors/failure.dart';

abstract class NotificationRepo {
  Future<Either<Failure, void>> sendNewProductNotification({
    required String productName,
    required String productId,
    required String imageUrl,
    bool isFeatured,
  });
}
