mixin AddProductFormValidators {
  String? requiredValidator(String? v) =>
      (v == null || v.trim().isEmpty) ? 'هذا الحقل مطلوب' : null;

  String? priceValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
    final price = double.tryParse(v);
    if (price == null || price <= 0) return 'أدخل سعراً صحيحاً';
    return null;
  }

  String? quantityValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'هذا الحقل مطلوب';
    final qty = int.tryParse(v);
    if (qty == null || qty < 0) return 'أدخل كمية صحيحة';
    return null;
  }
}
