import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/cubit/dashboard_order_cubit.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/dashboard_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const routeName = 'dashboard-view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardOrderCubit>(),
      child: const Scaffold(body: DashboardViewBody()),
    );
  }
}
