import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/core/utils/constants.dart';

import '../../services/database_service/database_service.dart';
import '../../services/storage_service/storage_service.dart';
import '../../../features/dashboard/domain/entities/add_product_entity.dart';
import 'product_repo.dart';
import '../../../features/dashboard/data/models/add_product_model.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl(this.databaseService, this.storageService);

  final DatabaseService databaseService;
  final StorageService storageService;

  @override
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity product,
    required File image,
  }) async {
    try {
      // 1. Upload image → get public URL.
      final String imageUrl = await _uploadImage(image);

      // 2. Build model with the uploaded URL.
      final model = ProductModel.fromEntity(
        AddProductEntity(
          name: product.name,
          price: product.price,
          quantity: product.quantity,
          description: product.description,
          imageUrl: imageUrl,
          isFeatured: product.isFeatured,
          code: product.code,
        ),
      );

      // 3. Persist to database via the shared service.
      await databaseService.addData(path: kProductTable, data: model.toJson());
      return const Right(null);
    } catch (e) {
      log('Exception in ProductRepoImpl.addProduct: ${e.toString()}');

      return Left(ServerFailure('Failed to add product. ${e.toString()}'));
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<String> _uploadImage(File image) async {
    try {
      return await storageService.uploadImage(image, kProductBucket);
    } catch (e) {
      log('Exception in ProductRepoImpl.uploadImage: ${e.toString()}');

      throw ServerFailure('Failed to upload product image, ${e.toString()}');
    }
  }
}
