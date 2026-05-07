import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';
import 'package:dashboard_fruit_hub/features/add_product/domain/entities/add_product_entity.dart';

abstract class AddProductRepo {
  Future<Either<Failure, void>> addProduct({required AddProductEntity product});
}
