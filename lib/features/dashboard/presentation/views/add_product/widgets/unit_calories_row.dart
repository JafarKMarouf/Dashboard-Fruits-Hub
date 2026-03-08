import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_form_field.dart';

class UnitCaloriesRow extends StatelessWidget {
  const UnitCaloriesRow({
    super.key,
    required this.numberOfCaloriesController,
    required this.unitAmountController,
    required this.numberValidator,
    required this.quantityValidator,
  });

  final TextEditingController numberOfCaloriesController;
  final TextEditingController unitAmountController;
  final String? Function(String?) numberValidator;
  final String? Function(String?) quantityValidator;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppTextFormField(
            label: 'كالوري',
            hintText: '100',
            controller: numberOfCaloriesController,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
            suffixText: 'كالوري',
            validator: numberValidator,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppTextFormField(
            label: 'الكالوري بالغرام',
            hintText: '100',
            suffixText: 'غرام',
            controller: unitAmountController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: quantityValidator,
          ),
        ),
      ],
    );
  }
}
