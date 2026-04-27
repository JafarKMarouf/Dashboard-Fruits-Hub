import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repos/image/image_repo.dart';
import '../../../../../core/repos/product/product_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductRepo productRepo;
  final ImageRepo imageRepo;
  AddProductCubit(this.productRepo, this.imageRepo)
    : super(AddProductInitial());

  Future<void> addProduct({required ProductEntity product}) async {
    emit(AddProductLoading());
    var result = await imageRepo.uploadImage(
      image: product.imageFile,
      path: 'Fruits',
    );
    result.fold((fail) => emit(AddProductFailure(fail.message)), (
      imageUrl,
    ) async {
      product.imageUrl = imageUrl;
      var productResult = await productRepo.addProduct(product: product);
      productResult.fold(
        (fail) => emit(AddProductFailure(fail.message)),
        (success) => emit(AddProductSuccess()),
      );
    });
  }
}
