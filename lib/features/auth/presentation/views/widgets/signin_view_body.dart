import 'package:dashboard_fruit_hub/core/l10n/l10n.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:dashboard_fruit_hub/core/utils/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles/app_images.dart';
import 'signin_form.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kTopPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                SvgPicture.asset(AppImages.imagesLogo),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .7,
                  child: AppTextWidget(
                    text: AppLocalizations.of(context).loginTitle,
                    style: AppTextStyles.styleBold13.copyWith(
                      color: AppColors.grayscale400,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SigninForm(),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'تواجه مشكله في الدخول؟ ',
                        style: AppTextStyles.styleBold13.copyWith(
                          color: AppColors.grayscale500,
                        ),
                      ),
                      TextSpan(
                        text: 'اتصل بالدعم الفني ',
                        style: AppTextStyles.styleBold13.copyWith(
                          color: AppColors.green1_500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
