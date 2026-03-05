import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../shared/widgets/bottom_nav_bar/app_shell.dart';
import 'custom_transition.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return fade(const SplashView());
    case SigninView.routeName:
      return slide(const SigninView());
    case AppShell.routeName:
      return fade(const AppShell());
    default:
      return fade(
        const Scaffold(
          body: Center(child: AppTextWidget('404 – Route not found')),
        ),
      );
  }
}
