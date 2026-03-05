import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';
import 'package:flutter/material.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const routeName = 'dashboard-view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: DashboardViewBody());
  }
}
