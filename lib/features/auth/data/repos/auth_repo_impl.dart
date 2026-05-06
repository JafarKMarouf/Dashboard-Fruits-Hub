import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/custom_exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/database/database_service.dart';
import '../../../../core/services/auth/firebase_auth_service.dart';
import '../../../../core/services/local/shared_prefs_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../../domain/requests/user_request.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(this.firebaseAuthService, this.databaseService);

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required UserRequest request,
  }) async {
    try {
      var user = await firebaseAuthService.signinWithEmailAndPassword(
        request: request,
      );
      UserEntity userEntity = await getUserData(uid: user.uid);
      if (userEntity.role != 'admin') {
        return Left(ServerFailure('notAuthorized'));
      }
      await saveUserData(user: userEntity);

      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signinWithEmailAndPassword: ${e.toString()}',
      );
      return Left(ServerFailure('genericError'));
    }
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var user = await databaseService.getData(
      path: BackendEndpoints.getUser,
      documentId: uid,
    );
    return UserModel.fromJson(user);
  }

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPrefsService.setString(kUserData, jsonData);
    await SharedPrefsService.setBool(kIsUserLoggedIn, true);
  }

  @override
  Future<void> signOut() async {
    await SharedPrefsService.remove(kUserData);
    await SharedPrefsService.remove(kIsUserLoggedIn);
  }
}
