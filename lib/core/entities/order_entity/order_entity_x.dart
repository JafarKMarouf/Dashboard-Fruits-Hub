import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import 'order_entity.dart';

extension OrderEntityX on OrderEntity {
  String formatPrice(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final amount = finalTotal == finalTotal.truncateToDouble()
        ? '${finalTotal.toInt()}'
        : finalTotal.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '');
    return '$amount ${l10n.currencySymbol}';
  }

  String formatOrderId(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (id == null || id!.length < 6) return l10n.orderIdFallback;
    final shortId = id!.substring(id!.length - 6).toUpperCase();
    return l10n.orderIdLabel(shortId);
  }
}
