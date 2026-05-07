import 'dart:io';

import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/core/services/image_picker/image_picker_service.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_form_field.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'price_quantity_row.dart';
import 'product_image_picker.dart';

class StepZeroContent extends StatelessWidget {
  const StepZeroContent({
    super.key,
    required this.nameController,
    required this.codeController,
    required this.priceController,
    required this.quantityController,
    required this.onImageSelected,
    required this.requiredValidator,
    required this.priceValidator,
    required this.quantityValidator,
  });

  final TextEditingController nameController;
  final TextEditingController codeController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final ValueChanged<File?> onImageSelected;
  final String? Function(String?) requiredValidator;
  final String? Function(String?) priceValidator;
  final String? Function(String?) quantityValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImagePicker(
          imagePickerService: getIt<ImagePickerService>(),
          onImageSelected: onImageSelected,
        ),
        const SizedBox(height: 20),
        AppTextFormField(
          controller: nameController,
          label: 'إسم المنتج',
          hintText: 'مثال: تفاح أحمر طازج',
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.edit_outlined,
              color: AppColors.grayscale300,
              size: 18,
            ),
          ),
          validator: requiredValidator,
        ),
        const SizedBox(height: 16),
        AppTextFormField(
          controller: codeController,
          label: 'كود المنتج',
          hintText: 'مثال: apple',
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: requiredValidator,
        ),
        const SizedBox(height: 16),
        PriceQuantityRow(
          priceController: priceController,
          quantityController: quantityController,
          priceValidator: priceValidator,
          quantityValidator: quantityValidator,
        ),
      ],
    );
  }
}
