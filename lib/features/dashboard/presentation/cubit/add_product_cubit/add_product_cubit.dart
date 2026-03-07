import 'dart:io';

import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repos/dashboard_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final DashboardRepo dashboardRepo;
  AddProductCubit(this.dashboardRepo) : super(AddProductInitial());
  Future<void> addProduct({
    required String name,
    required double price,
    required int quantity,
    required String description,
    required File image,
  }) async {
    emit(AddProductLoading());
    var result = await dashboardRepo.addProduct(
      product: ProductEntity(
        name: name,
        price: price,
        quantity: quantity,
        description: description,
        imageUrl: '',
      ),
      image: image,
    );
    result.fold(
      (fail) => emit(AddProductFailure(fail.message)),
      (success) => emit(AddProductSuccess()),
    );
  }
}
