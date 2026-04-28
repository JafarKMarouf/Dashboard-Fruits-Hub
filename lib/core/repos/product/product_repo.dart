import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';

import '../../../features/dashboard/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, void>> addProduct({required ProductEntity product});
}
