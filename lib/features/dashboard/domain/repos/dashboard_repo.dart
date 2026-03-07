import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dashboard_fruit_hub/core/errors/failure.dart';

import '../entities/product_entity.dart';

abstract class DashboardRepo {
  Future<Either<Failure, void>> addProduct({
    required ProductEntity product,
    required File image,
  });
}
