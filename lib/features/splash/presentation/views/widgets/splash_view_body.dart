import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/services/shared_preferences_service.dart';
import '../../../../../core/utils/shared/widgets/bottom_nav_bar/app_shell.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles/app_images.dart';
import '../../../../auth/presentation/views/signin_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    handleNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(AppImages.imagesPlant),
        ),
        SvgPicture.asset(AppImages.imagesLogo),
        SvgPicture.asset(AppImages.imagesSplashBottom, fit: BoxFit.fill),
      ],
    );
  }

  void handleNavigation() {
    Future.delayed(const Duration(seconds: 4), () {
      bool isLoggedIn = SharedPreferencesService.getBool(kIsUserLoggedIn);

      final String destination = isLoggedIn
          ? AppShell.routeName
          : SigninView.routeName;

      Navigator.pushReplacementNamed(context, destination);
    });
  }
}
