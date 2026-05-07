import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';
import '../../services/storage/storage_service.dart';
import 'image_repo.dart';

class ImageRepoImpl implements ImageRepo {
  final StorageService storageService;
  ImageRepoImpl(this.storageService);

  // ── Upload image ──────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, String>> uploadImage({
    required File image,
    required String path,
  }) async {
    try {
      return Right(await storageService.uploadImage(image, path));
    } catch (e) {
      log('Exception in ImageRepoImpl.uploadImage: ${e.toString()}');
      return Left(ServerFailure('Failed to upload image, ${e.toString()}'));
    }
  }
}
