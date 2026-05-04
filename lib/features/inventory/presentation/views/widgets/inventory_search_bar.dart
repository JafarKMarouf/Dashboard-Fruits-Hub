import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared/app_search_bar.dart';
import '../../manager/inventory_cubit/inventory_cubit.dart';

class InventorySearchBar extends StatelessWidget {
  const InventorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      hint: 'ابحث عن منتج...',
      onChanged: (q) => context.read<InventoryCubit>().search(q),
      onCleared: () => context.read<InventoryCubit>().clearSearch(),
    );
  }
}
