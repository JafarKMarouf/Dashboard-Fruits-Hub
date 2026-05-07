import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/core/utils/backend_endpoints.dart';

import '../../../../core/services/database/database_service.dart';
import '../../domain/entities/add_product_entity.dart';
import '../../domain/repos/add_product_repo.dart';
import '../models/add_product_model.dart';

class ProductRepoImpl implements AddProductRepo {
  final DatabaseService _databaseService;

  const ProductRepoImpl(this._databaseService);

  @override
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity product,
  }) async {
    try {
      await _databaseService.addData(
        path: BackendEndpoints.products,
        documentId: product.code,
        data: AddProductModel(product).toJson(),
      );
      log('✅ Product "${product.name}" saved to Firestore.');

      return const Right(null);
    } catch (e) {
      log('Exception in ProductRepoImpl.addProduct: ${e.toString()}');

      return Left(ServerFailure('فشل في اضافه المنتج.'));
    }
  }
}
