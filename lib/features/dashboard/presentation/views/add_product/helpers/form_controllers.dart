import 'package:flutter/material.dart';

class AddProductFormControllers {
  final name = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final description = TextEditingController();
  final code = TextEditingController();
  final expirationMonths = TextEditingController();
  final numberOfCalories = TextEditingController();
  final unitAmount = TextEditingController();

  void dispose() {
    name.dispose();
    price.dispose();
    quantity.dispose();
    description.dispose();
    code.dispose();
    expirationMonths.dispose();
    numberOfCalories.dispose();
    unitAmount.dispose();
  }
}
