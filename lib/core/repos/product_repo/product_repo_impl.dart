import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/core/utils/backend_endpoints.dart';

import '../../services/database_service/database_service.dart';
import '../../../features/dashboard/domain/entities/add_product_entity.dart';
import 'product_repo.dart';
import '../../../features/dashboard/data/models/add_product_model.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl(this.databaseService);

  final DatabaseService databaseService;

  @override
  Future<Either<Failure, void>> addProduct({
    required AddProductEntity product,
  }) async {
    try {
      await databaseService.addData(
        path: BackendEndpoints.addProduct,
        data: ProductModel.fromEntity(product).toJson(),
      );
      return const Right(null);
    } catch (e) {
      log('Exception in ProductRepoImpl.addProduct: ${e.toString()}');

      return Left(ServerFailure('Failed to add product. ${e.toString()}'));
    }
  }
}
