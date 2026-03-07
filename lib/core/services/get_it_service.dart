import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'database_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';
import 'image_picker/image_picker_service.dart';
import 'image_picker/image_picker_service_impl.dart';

final getIt = GetIt.instance;

/// Initializes and registers all app dependencies.
Future<void> setupServiceLocator() async {
  _registerAuthDependencies();
  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(),
  );
}

void _registerAuthDependencies() {
  /// Services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<DatabaseService>(() => FirestoreService());

  /// Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<FirebaseAuthService>(), getIt<DatabaseService>()),
  );

  /// Cubits
  getIt.registerFactory<SigninCubit>(() => SigninCubit(getIt<AuthRepo>()));
}
