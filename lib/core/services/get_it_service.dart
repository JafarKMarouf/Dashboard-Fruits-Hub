import 'package:dashboard_fruit_hub/core/repos/image/image_repo.dart';
import 'package:dashboard_fruit_hub/core/repos/image/image_repo_impl.dart';
import 'package:dashboard_fruit_hub/features/add_product/data/repos/add_product_repo_impl.dart';
import 'package:dashboard_fruit_hub/features/add_product/domain/repos/add_product_repo.dart';
import 'package:dashboard_fruit_hub/features/customers/data/repos/customers_repo_impl.dart';
import 'package:dashboard_fruit_hub/features/customers/domain/repos/customers_repo.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/dashboard_order_cubit/dashboard_order_cubit.dart';
import 'package:dashboard_fruit_hub/features/inventory/domain/repos/inventory_repo.dart';
import 'package:dashboard_fruit_hub/features/inventory/presentation/manager/inventory_cubit/inventory_cubit.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/repos/orders_repo.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/cubit/orders_cubit/orders_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import '../../features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import '../../features/dashboard/data/repos/dashboard_repo_impl.dart';
import '../../features/dashboard/domain/repos/dashboard_repo.dart';
import '../../features/add_product/presentation/manage/add_product_cubit/add_product_cubit.dart';
import '../../features/inventory/data/repos/inventory_repo_impl.dart';
import '../../features/orders/data/repos/orders_repo_impl.dart';
import '../repos/notification/notification_repo.dart';
import '../repos/notification/notification_repo_impl.dart';
import 'credential_vault/credential_vault.dart';
import 'credential_vault/credential_vault_impl.dart';
import 'database/database_service.dart';
import 'database/firestore_service.dart';
import 'auth/firebase_auth_service.dart';
import 'fcm/fcm_service.dart';
import 'fcm/fcm_service_impl.dart';
import 'image_picker/image_picker_service.dart';
import 'image_picker/image_picker_service_impl.dart';
import 'storage/storage_service.dart';
import 'storage/supabase_storage.dart';

final getIt = GetIt.instance;

/// Initializes and registers all app dependencies.
Future<void> setupServiceLocator() async {
  await _registerServices();
  _registerRepositories();
  _registerCubits();
}

Future<void> _registerServices() async {
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<DatabaseService>(() => FirestoreService());

  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(),
  );

  getIt.registerLazySingleton<StorageService>(() => SupabaseStorage());

  final vault = CredentialVaultImpl();
  await vault.init();
  getIt.registerLazySingleton<CredentialVault>(() => vault);

  getIt.registerLazySingleton<FcmService>(
    () => FcmServiceImpl(getIt<CredentialVault>()),
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<FirebaseAuthService>(), getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<AddProductRepo>(
    () => ProductRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<ImageRepo>(
    () => ImageRepoImpl(getIt<StorageService>()),
  );

  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<OrdersRepo>(
    () => OrdersRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<InventoryRepo>(
    () => InventoryRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<CustomersRepo>(
    () => CustomersRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(getIt<FcmService>(), getIt<DatabaseService>()),
  );
}

void _registerCubits() {
  getIt.registerFactory<SigninCubit>(() => SigninCubit(getIt<AuthRepo>()));
  getIt.registerFactory<AddProductCubit>(
    () => AddProductCubit(
      getIt<AddProductRepo>(),
      getIt<ImageRepo>(),
      getIt<NotificationRepo>(),
    ),
  );

  getIt.registerFactory<DashboardOrderCubit>(
    () => DashboardOrderCubit(getIt<DashboardRepo>()),
  );

  getIt.registerFactory<OrdersCubit>(() => OrdersCubit(getIt<OrdersRepo>()));

  getIt.registerFactory<InventoryCubit>(
    () => InventoryCubit(getIt<InventoryRepo>()),
  );
  getIt.registerFactory<CustomersCubit>(
    () => CustomersCubit(getIt<CustomersRepo>()),
  );
}
