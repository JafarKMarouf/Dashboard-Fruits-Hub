part of 'add_product_cubit.dart';

sealed class AddProductState {
  const AddProductState();
}

final class AddProductInitial extends AddProductState {
  const AddProductInitial();
}

final class AddProductLoading extends AddProductState {
  const AddProductLoading();
}

final class AddProductFailure extends AddProductState {
  final String message;
  const AddProductFailure(this.message);
}

final class AddProductSuccess extends AddProductState {
  final bool notificationSent;
  const AddProductSuccess({this.notificationSent = true});
}
