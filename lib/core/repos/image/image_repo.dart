import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';

abstract class ImageRepo {
  Future<Either<Failure, String>> uploadImage({
    required File image,
    required String path,
  });
}
