import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../requests/user_request.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required UserRequest request,
  });

  Future<void> saveUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String uid});

  Future<void> signOut();
}
