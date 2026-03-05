import 'package:flutter/material.dart';

import '../../utils/styles/app_text_styles.dart';
import 'app_text_widget.dart';

AppBar buildAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Navigator.canPop(context)
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )
        : null,
    centerTitle: true,
    title: AppTextWidget(title, style: AppTextStyles.styleBold19),
  );
}
