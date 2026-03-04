import 'dart:developer';

import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:dashboard_fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:dashboard_fruit_hub/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const routeName = 'dashboard-view';
  @override
  Widget build(BuildContext context) {
    log(routeName);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 400), () {
              getIt<AuthRepo>().signOut();
            });
            Navigator.pushNamedAndRemoveUntil(
              context,
              SigninView.routeName,
              (route) => false,
            );
          },
          icon: const Icon(Icons.exit_to_app, color: AppColors.grayscale900),
        ),
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
