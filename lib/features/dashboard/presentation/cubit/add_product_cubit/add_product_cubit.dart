import 'dart:io';

import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/add_product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repos/product_repo/product_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductRepo productRepo;
  AddProductCubit(this.productRepo) : super(AddProductInitial());
  Future<void> addProduct({
    required AddProductEntity product,
    required File image,
  }) async {
    emit(AddProductLoading());
    var result = await productRepo.addProduct(product: product, image: image);
    result.fold(
      (fail) => emit(AddProductFailure(fail.message)),
      (success) => emit(AddProductSuccess()),
    );
  }
}
