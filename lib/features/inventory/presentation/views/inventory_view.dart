import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/features/inventory/presentation/manager/inventory_cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/inventory_view_body.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  static const routeName = 'inventory-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryCubit>()..startWatching(),
      child: const InventoryViewBody(),
    );
  }
}
