import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';

class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({super.key, required this.name});

  final String name;
  static const List<_AvatarColor> _palette = [
    _AvatarColor(bg: AppColors.green50, fg: AppColors.green700),
    _AvatarColor(bg: AppColors.green1_50, fg: AppColors.green1_600),
    _AvatarColor(bg: AppColors.green100, fg: AppColors.green800),
    _AvatarColor(bg: AppColors.orange50, fg: AppColors.orange600),
    _AvatarColor(bg: AppColors.orange100, fg: AppColors.orange700),
    _AvatarColor(bg: AppColors.green1_100, fg: AppColors.green1_700),
    _AvatarColor(bg: AppColors.orange200, fg: AppColors.orange800),
    _AvatarColor(bg: AppColors.green200, fg: AppColors.green900),
  ];

  _AvatarColor get _colors {
    final index = name.isNotEmpty ? name.codeUnitAt(0) % _palette.length : 0;
    return _palette[index];
  }

  String get _initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return String.fromCharCode(trimmed.runes.first).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colors;

    // final color = _avatarColor();
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colors.bg,
        shape: BoxShape.circle,
        border: Border.all(color: colors.fg.withOpacity(0.25), width: 1.5),
      ),
      alignment: Alignment.center,
      child: AppTextWidget(
        _initial,
        style: AppTextStyles.styleBold23.copyWith(color: colors.fg, height: 1),
      ),
    );
  }
}

class _AvatarColor {
  const _AvatarColor({required this.bg, required this.fg});
  final Color bg;
  final Color fg;
}
