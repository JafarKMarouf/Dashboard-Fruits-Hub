// core/utils/extensions/date_time_extensions.dart

import 'package:dashboard_fruit_hub/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

extension NullableDateTimeArabicX on DateTime? {
  String arabicTimeAgo(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (this == null) return l10n.timeAgoMoments;

    // final diff = DateTime.now().difference(this!);
    final diff = DateTime.now().toUtc().difference(this!.toUtc());

    if (diff.inSeconds < 60) return ' ${l10n.timeAgoMoments}';

    if (diff.inMinutes < 60) {
      return _arabicUnit(
        diff.inMinutes,
        l10n.timeAgoMinuteOne,
        l10n.timeAgoMinuteTwo,
        l10n.timeAgoMinutePlural,
      );
    }
    if (diff.inHours < 24) {
      return _arabicUnit(
        diff.inHours,
        l10n.timeAgoHourOne,
        l10n.timeAgoHourTwo,
        l10n.timeAgoHourPlural,
      );
    }
    if (diff.inDays < 30) {
      return _arabicUnit(
        diff.inDays,
        l10n.timeAgoDayOne,
        l10n.timeAgoDayTwo,
        l10n.timeAgoDayPlural,
      );
    }
    if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return _arabicUnit(
        months,
        l10n.timeAgoMonthOne,
        l10n.timeAgoMonthTwo,
        l10n.timeAgoMonthPlural,
      );
    }
    final years = (diff.inDays / 365).floor();
    return _arabicUnit(
      years,
      l10n.timeAgoYearOne,
      l10n.timeAgoYearTwo,
      l10n.timeAgoYearPlural,
    );
  }

  /// Arabic grammar: 1→singular, 2→dual, 3-10→plural, 11+→singular+number
  String _arabicUnit(int n, String one, String two, String plural) {
    if (n == 1) return one;
    if (n == 2) return two;
    if (n <= 10) return '$n $plural';
    return '$n $one';
  }
}
