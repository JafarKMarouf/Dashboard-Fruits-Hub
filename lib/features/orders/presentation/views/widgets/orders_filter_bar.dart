import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/order_status.dart';
import '../../../../../core/utils/shared/app_filter_bar.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';

class OrdersFilterBar extends StatelessWidget {
  const OrdersFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrdersCubit>();

    final activeFilter = switch (cubit.state) {
      OrdersLoadedState(activeFilter: final f) => f,
      _ => OrderStatus.all,
    };

    return AppFilterBar<OrderStatus>(
      activeValue: activeFilter,
      onSelected: cubit.filterByStatus,
      items: OrderStatus.values
          .map(
            (s) => FilterItem(
              value: s,
              label: s.labelAr,
              count: cubit.countByStatus(s),
              bgColor: s.bg,
              fgColor: s.fg,
              icon: s.icon,
            ),
          )
          .toList(),
    );
  }
}
