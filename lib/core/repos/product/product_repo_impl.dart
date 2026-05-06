import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/core/utils/backend_endpoints.dart';

import '../../services/database/database_service.dart';
import '../../../features/dashboard/domain/entities/product_entity.dart';
import 'product_repo.dart';
import '../../../features/dashboard/data/models/product_model.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl(this.databaseService);

  final DatabaseService databaseService;

  @override
  Future<Either<Failure, void>> addProduct({
    required ProductEntity product,
  }) async {
    try {
      await databaseService.addData(
        path: BackendEndpoints.addProduct,
        data: ProductModel.fromEntity(product).toJson(),
      );
      return const Right(null);
    } catch (e) {
      log('Exception in ProductRepoImpl.addProduct: ${e.toString()}');

      return Left(ServerFailure('فشل في اضافه المنتج.'));
    }
  }
}
