import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/customers_view_body.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  static const routeName = 'customers-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomersCubit>()..startWatching(),
      child: const CustomersViewBody(),
    );
  }
}
