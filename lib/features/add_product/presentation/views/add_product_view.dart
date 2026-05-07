import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/manage/add_product_cubit/add_product_cubit.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/views/widgets/add_product_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});
  static const routeName = 'add-product';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductCubit>(),
      child: const AddProductBlocConsumer(),
    );
  }
}
