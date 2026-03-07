import 'package:dashboard_fruit_hub/core/services/database_service/supabase_store_service.dart';
import 'package:dashboard_fruit_hub/features/dashboard/data/repos/dashboard_repo_impl.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/repos/dashboard_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import '../../features/dashboard/presentation/cubit/add_product_cubit/add_product_cubit.dart'
    show AddProductCubit;
import 'database_service/database_service.dart';
import 'database_service/firestore_service.dart';
import 'firebase_auth_service.dart';
import 'image_picker/image_picker_service.dart';
import 'image_picker/image_picker_service_impl.dart';

final getIt = GetIt.instance;

/// Initializes and registers all app dependencies.
Future<void> setupServiceLocator() async {
  _registerServices();
  _registerRepositories();
  _registerCubits();
}

void _registerServices() {
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<DatabaseService>(
    () => FirestoreService(),
    instanceName: 'firestore',
  );

  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(),
  );

  getIt.registerLazySingleton<DatabaseService>(
    () => SupabaseStoreService(),
    instanceName: 'supabase',
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt<FirebaseAuthService>(),
      getIt<DatabaseService>(instanceName: 'firestore'),
    ),
  );
  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(getIt<DatabaseService>(instanceName: 'supabase')),
  );
}

void _registerCubits() {
  getIt.registerFactory<SigninCubit>(() => SigninCubit(getIt<AuthRepo>()));
  getIt.registerFactory<AddProductCubit>(
    () => AddProductCubit(getIt<DashboardRepo>()),
  );
}
