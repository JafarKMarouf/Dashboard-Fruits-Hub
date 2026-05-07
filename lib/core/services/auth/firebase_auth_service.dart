import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../features/auth/domain/requests/user_request.dart';
import '../../errors/custom_exceptions.dart';

class FirebaseAuthService {
  Future<User> signinWithEmailAndPassword({
    required UserRequest request,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'FirebaseAuthException in FirebaseAuthService.signinWithEmailAndPassword: ${e.toString()}, and code: ${e.code}',
      );
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'invalidEmail');
        case 'invalid-credential':
          throw CustomException(message: 'invalidCredential');
        case 'network-request-failed':
          throw CustomException(message: 'networkRequestFailed');
        default:
          throw CustomException(message: 'genericError');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.signinWithEmailAndPassword: ${e.toString()}',
      );

      throw CustomException(message: 'genericError');
    }
  }

  Future<void> deleteAuthUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
