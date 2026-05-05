import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_images.dart';
import '../../styles/app_text_styles.dart';
import 'app_text_widget.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu_rounded),
        AppTextWidget(title, style: AppTextStyles.styleBold16),
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
