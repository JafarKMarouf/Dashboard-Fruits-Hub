import 'dart:io';

import 'package:dashboard_fruit_hub/core/shared/widgets/app_primary_button.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_form_field.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import 'product_image_picker.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _productImage;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProductImagePicker(
            onImageSelected: (file) => setState(() => _productImage = file),
          ),
          const SizedBox(height: 20),

          AppTextFormField(
            controller: _nameController,
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
          ),
          const SizedBox(height: 16),

          _buildPriceQuantityRow(),
          const SizedBox(height: 16),
          AppTextFormField(
            label: 'وصف المنتج',
            hintText: 'أدخل وصفاً مختصراً للمنتج...',
            controller: _descriptionController,
            maxLines: 4,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 28),
          AppPrimaryButton(
            onPressed: () {},
            colorShadow: AppColors.borderLight,
            backgroundColor: AppColors.secondary,
            height: 56,
            widget: Row(
              mainAxisAlignment: .center,
              children: [
                const Icon(Icons.save_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                AppTextWidget(
                  'حفظ المنتج',
                  style: AppTextStyles.styleBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildPriceQuantityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price
        Expanded(
          child: AppTextFormField(
            label: 'السعر',
            hintText: '0.00',
            controller: _priceController,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            textInputAction: TextInputAction.next,
            suffixText: 'ل.س',
          ),
        ),
        const SizedBox(width: 12),
        // Quantity
        Expanded(
          child: AppTextFormField(
            label: 'الكمية',
            hintText: '0',
            controller: _quantityController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            // validator: _requiredValidator,
          ),
        ),
      ],
    );
  }
}
