import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_form_field.dart';

class PriceQuantityRow extends StatelessWidget {
  const PriceQuantityRow({
    super.key,
    required this.priceController,
    required this.quantityController,
    required this.priceValidator,
    required this.quantityValidator,
  });

  final TextEditingController priceController;
  final TextEditingController quantityController;
  final String? Function(String?) priceValidator;
  final String? Function(String?) quantityValidator;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppTextFormField(
            label: 'السعر',
            hintText: '0.00',
            controller: priceController,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            textInputAction: TextInputAction.next,
            suffixText: 'ل.س',
            validator: priceValidator,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppTextFormField(
            label: 'الكمية',
            hintText: '0',
            controller: quantityController,
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
