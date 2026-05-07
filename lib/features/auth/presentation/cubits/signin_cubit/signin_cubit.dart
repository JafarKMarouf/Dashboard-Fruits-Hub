import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repos/auth_repo.dart';
import '../../../domain/requests/user_request.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepo authRepo;

  SigninCubit(this.authRepo) : super(SigninInitial());

  Future<void> signin({required UserRequest request}) async {
    emit(SigninLoading());

    final result = await authRepo.signInWithEmailAndPassword(request: request);
    result.fold(
      (failure) => emit(SigninFailure(failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }
}
