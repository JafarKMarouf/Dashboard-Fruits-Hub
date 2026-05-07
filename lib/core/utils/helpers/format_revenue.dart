String formatRevenue(double value) {
  if (value >= 1000) {
    final k = value / 1000;
    final s = k == k.truncateToDouble()
        ? '${k.toInt()}K'
        : '${k.toStringAsFixed(1)}K';
    return '$s ل.س';
  }
  if (value == value.truncateToDouble()) return '${value.toInt()} ل.س';
  return '${value.toStringAsFixed(2)} ل.س';
}
