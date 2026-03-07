import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/core/utils/constants.dart';

import '../../../../core/services/database_service/database_service.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repos/dashboard_repo.dart';
import '../models/product_model.dart';

class DashboardRepoImpl implements DashboardRepo {
  DashboardRepoImpl(this.db);

  final DatabaseService db;

  @override
  Future<Either<Failure, void>> addProduct({
    required ProductEntity product,
    required File image,
  }) async {
    try {
      // 1. Upload image → get public URL.
      final String imageUrl = await _uploadImage(image);

      // 2. Build model with the uploaded URL.
      final model = ProductModel.fromEntity(
        ProductEntity(
          name: product.name,
          price: product.price,
          quantity: product.quantity,
          description: product.description,
          imageUrl: imageUrl,
        ),
      );

      // 3. Persist to database via the shared service.
      await db.addData(path: kProductTable, data: model.toJson());
      return const Right(null);
    } catch (e) {
      log('Exception in DashboardRepoImpl.addProduct: ${e.toString()}');

      return Left(ServerFailure('Failed to add product. ${e.toString()}'));
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<String> _uploadImage(File image) async {
    try {
      return db.uploadImage(image, kProductTable);
    } catch (e) {
      log('Exception in DashboardRepoImpl.uploadImage: ${e.toString()}');

      throw ServerFailure('Failed to upload product image, ${e.toString()}');
    }
  }
}
