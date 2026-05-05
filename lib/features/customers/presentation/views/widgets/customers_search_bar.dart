import 'package:dashboard_fruit_hub/features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared/app_search_bar.dart';

class CustomersSearchBar extends StatelessWidget {
  const CustomersSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      hint: 'ابحث عن مستخدمين...',
      onChanged: (q) => context.read<CustomersCubit>().search(q),
      onCleared: () => context.read<CustomersCubit>().clearSearch(),
    );
  }
}
