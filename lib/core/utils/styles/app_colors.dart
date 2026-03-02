import 'package:flutter/material.dart';

abstract class AppColors {
  // ==================== GRAYSCALE ====================
  static final Color grayscale50 = const Color(0xfff2f3f3);
  static final Color grayscale100 = const Color(0xffe4e6e7);
  static final Color grayscale200 = const Color(0xffdee1e2);
  static final Color grayscale300 = const Color(0xffafb5b6);
  static final Color grayscale400 = const Color(0xff949d9e);
  static final Color grayscale500 = const Color(0xff4e5556);
  static final Color grayscale600 = const Color(0xff616a6b);
  static final Color grayscale700 = const Color(0xff494f50);
  static final Color grayscale800 = const Color(0xff313535);
  static final Color grayscale900 = const Color(0xff181a1b);
  static final Color grayscale950 = const Color(0xff0c0d0d);

  // ==================== GREEN ====================
  static final Color green50 = const Color(0xffeefbea);
  static final Color green100 = const Color(0xffddf7d4);
  static final Color green200 = const Color(0xffbbefa9);
  static final Color green300 = const Color(0xff98e77e);
  static final Color green400 = const Color(0xff76df53);
  static final Color green500 = const Color(0xff6cdc46);
  static final Color green600 = const Color(0xff43ac20);
  static final Color green700 = const Color(0xff328118);
  static final Color green800 = const Color(0xff225610);
  static final Color green900 = const Color(0xff112b08);
  static final Color green950 = const Color(0xff081504);

  // ==================== ORANGE ====================
  static final Color orange50 = const Color(0xfffef6e7);
  static final Color orange100 = const Color(0xfffdecce);
  static final Color orange200 = const Color(0xfffada9e);
  static final Color orange300 = const Color(0xfff8c76d);
  static final Color orange400 = const Color(0xfff5b53d);
  static final Color orange500 = const Color(0xfff4a91f);
  static final Color orange600 = const Color(0xffc2820a);
  static final Color orange700 = const Color(0xff926107);
  static final Color orange800 = const Color(0xff614105);
  static final Color orange900 = const Color(0xff312002);
  static final Color orange950 = const Color(0xff181001);

  // ==================== GREEN1 ====================
  static final Color green1_50 = const Color(0xffebf9f1);
  static final Color green1_100 = const Color(0xffd7f4e3);
  static final Color green1_200 = const Color(0xffb0e8c7);
  static final Color green1_300 = const Color(0xff88ddab);
  static final Color green1_400 = const Color(0xff60d290);
  static final Color green1_500 = const Color(0xff1b5e37);
  static final Color green1_600 = const Color(0xff2d9f5d);
  static final Color green1_700 = const Color(0xff227745);
  static final Color green1_800 = const Color(0xff174f2e);
  static final Color green1_900 = const Color(0xff0b2817);
  static final Color green1_950 = const Color(0xff06140c);

  // ==================== SEMANTIC COLORS (Optional) ====================
  // Primary
  static final Color primary = green600;
  static final Color primaryLight = green400;
  static final Color primaryDark = green700;

  // Secondary
  static final Color secondary = orange500;
  static final Color secondaryLight = orange300;
  static final Color secondaryDark = orange700;

  // Surface
  static final Color surface = grayscale50;
  static final Color surfaceVariant = grayscale100;

  // Text
  static final Color textPrimary = grayscale900;
  static final Color textSecondary = grayscale600;
  static final Color textTertiary = grayscale400;
  static final Color textDisabled = grayscale300;

  // Background
  static final Color background = grayscale50;
  static final Color backgroundAlt = grayscale100;

  // Border
  static final Color border = grayscale200;
  static final Color borderLight = grayscale100;

  // Utility
  static final Color error = orange600;
  static final Color success = green500;
  static final Color warning = orange400;
  static final Color info = green1_500;
}
