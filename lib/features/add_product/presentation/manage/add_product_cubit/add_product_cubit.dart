import 'package:dashboard_fruit_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repos/image/image_repo.dart';
import '../../../../../core/repos/notification/notification_repo.dart';
import '../../../domain/repos/add_product_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final AddProductRepo productRepo;
  final ImageRepo imageRepo;
  final NotificationRepo notificationRepo;

  AddProductCubit(this.productRepo, this.imageRepo, this.notificationRepo)
    : super(const AddProductInitial());

  Future<void> addProduct({required AddProductEntity product}) async {
    emit(const AddProductLoading());

    // ── Step 1: upload image ───────────────────────────────────────────────
    final imageResult = await imageRepo.uploadImage(
      image: product.imageFile,
      path: 'Fruits',
    );
    if (imageResult.isLeft()) {
      emit(AddProductFailure(imageResult.fold((f) => f.message, (_) => '')));
      return;
    }
    final imageUrl = imageResult.getOrElse(() => '');
    product.imageUrl = imageUrl;

    // ── Step 2: save product to Firestore ────────────────────────────
    final productResult = await productRepo.addProduct(product: product);
    if (productResult.isLeft()) {
      emit(AddProductFailure(productResult.fold((f) => f.message, (_) => '')));
      return;
    }

    // ── Step 3: send push notification ──────────────────────────
    final notifResult = await notificationRepo.sendNewProductNotification(
      productName: product.name,
      productId: product.code,
      imageUrl: imageUrl,
      isFeatured: product.isFeatured,
    );
    emit(AddProductSuccess(notificationSent: notifResult.isRight()));
  }
}
