import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_images.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu_rounded),
        AppTextWidget(
          AppLocalizations.of(context).dashboardTitle,
          style: AppTextStyles.styleBold19,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const ShapeDecoration(
            color: Color(0xFFEEF8ED),
            shape: OvalBorder(),
          ),
          child: SvgPicture.asset(AppImages.imagesNotification),
        ),
      ],
    );
  }
}
