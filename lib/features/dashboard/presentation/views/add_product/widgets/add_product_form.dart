import 'dart:io';

import 'package:dashboard_fruit_hub/core/services/get_it_service.dart';
import 'package:dashboard_fruit_hub/core/services/image_picker/image_picker_service.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_primary_button.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_form_field.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/add_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helpers/build_messages_bar.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../cubit/add_product_cubit/add_product_cubit.dart';
import 'is_featured_checkbox.dart';
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
  final _codeController = TextEditingController();
  File? _productImage;
  late bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_productImage == null) {
      buildErrorBar(context, 'يرجى اختيار صورة للمنتج');
      return;
    }

    context.read<AddProductCubit>().addProduct(
      product: AddProductEntity(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        quantity: int.parse(_quantityController.text.trim()),
        description: _descriptionController.text.trim(),
        isFeatured: _isFeatured,
        code: _codeController.text.toLowerCase().trim(),
      ),
      image: _productImage!,
    );
  }

  // ── Validators ──────────────────────────────────────────────────────────────

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty) ? 'هذا الحقل مطلوب' : null;

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
    final price = double.tryParse(value);
    if (price == null || price <= 0) return 'أدخل سعراً صحيحاً';
    return null;
  }

  String? _quantityValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
    final qty = int.tryParse(value);
    if (qty == null || qty < 0) return 'أدخل كمية صحيحة';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProductImagePicker(
            imagePickerService: getIt<ImagePickerService>(),
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
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),

          AppTextFormField(
            controller: _codeController,
            label: 'كود المنتج',
            hintText: 'مثال: abcdef',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),

          _buildPriceQuantityRow(),
          const SizedBox(height: 16),
          IsFeaturedCheckbox(
            changed: (value) {
              setState(() {
                _isFeatured = value;
              });
            },
          ),
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
          buildSubmitButton(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  AppPrimaryButton buildSubmitButton() {
    return AppPrimaryButton(
      onPressed: _onSubmit,
      colorShadow: AppColors.borderLight,
      backgroundColor: AppColors.primaryDark,
      height: 56,
      widget: Row(
        mainAxisAlignment: .center,
        children: [
          const Icon(Icons.save_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          AppTextWidget(
            'حفظ المنتج',
            style: AppTextStyles.styleBold16.copyWith(color: Colors.white),
          ),
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
            validator: _priceValidator,
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
            validator: _quantityValidator,
          ),
        ),
      ],
    );
  }
}
