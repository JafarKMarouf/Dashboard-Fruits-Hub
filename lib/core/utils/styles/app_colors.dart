import 'package:flutter/material.dart';

abstract class AppColors {
  // ==================== GRAYSCALE ====================
  static const Color grayscale50 = Color(0xfff2f3f3);
  static const Color grayscale100 = Color(0xffe4e6e7);
  static const Color grayscale200 = Color(0xffdee1e2);
  static const Color grayscale300 = Color(0xffafb5b6);
  static const Color grayscale400 = Color(0xff949d9e);
  static const Color grayscale500 = Color(0xff4e5556);
  static const Color grayscale600 = Color(0xff616a6b);
  static const Color grayscale700 = Color(0xff494f50);
  static const Color grayscale800 = Color(0xff313535);
  static const Color grayscale900 = Color(0xff181a1b);
  static const Color grayscale950 = Color(0xff0c0d0d);

  // ==================== GREEN ====================
  static const Color green50 = Color(0xffeefbea);
  static const Color green100 = Color(0xffddf7d4);
  static const Color green200 = Color(0xffbbefa9);
  static const Color green300 = Color(0xff98e77e);
  static const Color green400 = Color(0xff76df53);
  static const Color green500 = Color(0xff6cdc46);
  static const Color green600 = Color(0xff43ac20);
  static const Color green700 = Color(0xff328118);
  static const Color green800 = Color(0xff225610);
  static const Color green900 = Color(0xff112b08);
  static const Color green950 = Color(0xff081504);

  // ==================== ORANGE ====================
  static const Color orange50 = Color(0xfffef6e7);
  static const Color orange100 = Color(0xfffdecce);
  static const Color orange200 = Color(0xfffada9e);
  static const Color orange300 = Color(0xfff8c76d);
  static const Color orange400 = Color(0xfff5b53d);
  static const Color orange500 = Color(0xfff4a91f);
  static const Color orange600 = Color(0xffc2820a);
  static const Color orange700 = Color(0xff926107);
  static const Color orange800 = Color(0xff614105);
  static const Color orange900 = Color(0xff312002);
  static const Color orange950 = Color(0xff181001);

  // ==================== GREEN1 ====================
  static const Color green1_50 = Color(0xffebf9f1);
  static const Color green1_100 = Color(0xffd7f4e3);
  static const Color green1_200 = Color(0xffb0e8c7);
  static const Color green1_300 = Color(0xff88ddab);
  static const Color green1_400 = Color(0xff60d290);
  static const Color green1_500 = Color(0xff1b5e37);
  static const Color green1_600 = Color(0xff2d9f5d);
  static const Color green1_700 = Color(0xff227745);
  static const Color green1_800 = Color(0xff174f2e);
  static const Color green1_900 = Color(0xff0b2817);
  static const Color green1_950 = Color(0xff06140c);

  // ==================== SEMANTIC COLORS (Optional) ====================
  // Primary
  static const Color primary = green600;
  static const Color primaryLight = green400;
  static const Color primaryDark = green700;

  // Secondary
  static const Color secondary = orange500;
  static const Color secondaryLight = orange300;
  static const Color secondaryDark = orange700;

  // Surface
  static const Color surface = grayscale50;
  static const Color surfaceVariant = grayscale100;

  // Text
  static const Color textPrimary = grayscale900;
  static const Color textSecondary = grayscale600;
  static const Color textTertiary = grayscale400;
  static const Color textDisabled = grayscale300;

  // Background
  static const Color background = grayscale50;
  static const Color backgroundAlt = grayscale100;

  // Border
  static const Color border = grayscale200;
  static const Color borderLight = grayscale100;

  // Utility
  static const Color error = orange600;
  static const Color success = green500;
  static const Color warning = orange400;
  static const Color info = green1_500;
}
