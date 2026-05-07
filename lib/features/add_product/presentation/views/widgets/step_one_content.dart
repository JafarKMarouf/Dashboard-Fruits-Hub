import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_form_field.dart';
import 'package:dashboard_fruit_hub/core/utils/constants.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/views/widgets/is_featured_checkbox.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/views/widgets/is_organic_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'unit_calories_row.dart';

class StepOneContent extends StatelessWidget {
  const StepOneContent({
    super.key,
    required this.expierationMonthsController,
    required this.numberOfCaloriesController,
    required this.unitAmountController,
    required this.descriptionController,
    required this.onFeaturedChanged,
    required this.onOrganicChanged,
    required this.requiredValidator,
    required this.numberValidator,
    required this.quantityValidator,
    this.initialFeatured = false,
    this.initialOrganic = false,
  });

  final TextEditingController expierationMonthsController;
  final TextEditingController numberOfCaloriesController;
  final TextEditingController unitAmountController;
  final TextEditingController descriptionController;
  final ValueChanged<bool> onFeaturedChanged;
  final ValueChanged<bool> onOrganicChanged;
  final String? Function(String?) requiredValidator;
  final String? Function(String?) numberValidator;
  final String? Function(String?) quantityValidator;
  final bool initialFeatured;
  final bool initialOrganic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kTopPadding),
        AppTextFormField(
          controller: expierationMonthsController,
          label: 'الصلاحية',
          hintText: '12',
          suffixText: 'شهر',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
          validator: requiredValidator,
        ),
        const SizedBox(height: 16),
        UnitCaloriesRow(
          numberOfCaloriesController: numberOfCaloriesController,
          unitAmountController: unitAmountController,
          numberValidator: numberValidator,
          quantityValidator: quantityValidator,
        ),
        const SizedBox(height: 24),
        IsFeaturedCheckbox(
          changed: onFeaturedChanged,
          initialValue: initialFeatured,
        ),
        const SizedBox(height: 16),
        IsOrganicCheckbox(
          changed: onOrganicChanged,
          initialValue: initialFeatured,
        ),
        const SizedBox(height: 16),
        AppTextFormField(
          label: 'وصف المنتج',
          hintText: 'أدخل وصفاً مختصراً للمنتج...',
          controller: descriptionController,
          maxLines: 4,
          textInputType: TextInputType.multiline,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
