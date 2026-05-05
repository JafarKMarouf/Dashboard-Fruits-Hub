import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/customer_status.dart';
import '../../../../../core/utils/shared/app_filter_bar.dart';
import '../../manager/customer_cubit/customers_cubit.dart';

class CustomersFilterBar extends StatelessWidget {
  const CustomersFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CustomersCubit>();

    final activeFilter = switch (cubit.state) {
      CustomersLoadedState(activeFilter: final f) => f,
      _ => CustomerStatus.all,
    };

    return AppFilterBar<CustomerStatus>(
      activeValue: activeFilter,
      onSelected: cubit.filterByStatus,
      items: CustomerStatus.values
          .map(
            (s) => FilterItem(
              value: s,
              label: s.label,
              count: cubit.countByStatus(s),
              bgColor: s.bgColor,
              fgColor: s.fgColor,
              icon: s.icon,
            ),
          )
          .toList(),
    );
  }
}
