import 'dart:io';

import 'package:dashboard_fruit_hub/core/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/product_entity.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/add_product_cubit/add_product_cubit.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/add_product/widgets/review_step.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/add_product/widgets/step_buttons.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/add_product/widgets/step_indicator.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/add_product/widgets/step_one_content.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/add_product/widgets/step_zero_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/form_controllers.dart';
import '../helpers/form_validators.dart';
import 'step_animated_switcher.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm>
    with AddProductFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _controllers = AddProductFormControllers();

  File? _productImage;
  bool _isFeatured = false;
  bool _isOrganic = false;
  int _currentStep = 0;
  bool _forward = true;

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  // ── Navigation ──────────────────────────────────────────────────────────────
  void _goToNextStep() {
    if (!_formKey.currentState!.validate()) return;
    if (_currentStep == 0 && _productImage == null) {
      buildWarningBar(context, 'يرجى اختيار صورة للمنتج');
      return;
    }
    if (_currentStep < 2) {
      setState(() {
        _forward = true;
        _currentStep++;
      });
    } else {
      _onSubmit();
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _forward = false;
        _currentStep--;
      });
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (_productImage == null) {
      showErrorBar(context, 'يرجى اختيار صورة للمنتج');
      return;
    }
    context.read<AddProductCubit>().addProduct(
      product: ProductEntity(
        name: _controllers.name.text.trim(),
        price: double.parse(_controllers.price.text.trim()),
        quantity: int.parse(_controllers.quantity.text.trim()),
        description: _controllers.description.text.trim(),
        isFeatured: _isFeatured,
        code: _controllers.code.text.toLowerCase().trim(),
        imageFile: _productImage!,
        isOrganic: _isOrganic,
        expirationMonths: int.parse(_controllers.expirationMonths.text),
        numberOfCalories: int.parse(_controllers.numberOfCalories.text),
        unitAmount: int.parse(_controllers.unitAmount.text),
        reviews: [],
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          StepIndicator(currentStep: _currentStep),
          const SizedBox(height: 16),
          StepAnimatedSwitcher(
            currentStep: _currentStep,
            forward: _forward,
            child: _buildStepContent(),
          ),
          const SizedBox(height: 28),
          StepButtons(
            currentStep: _currentStep,
            onNext: _goToNextStep,
            onPrevious: _goToPreviousStep,
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    return switch (_currentStep) {
      0 => StepZeroContent(
        nameController: _controllers.name,
        codeController: _controllers.code,
        priceController: _controllers.price,
        quantityController: _controllers.quantity,
        onImageSelected: (file) => setState(() => _productImage = file),
        requiredValidator: requiredValidator,
        priceValidator: priceValidator,
        quantityValidator: quantityValidator,
      ),
      1 => StepOneContent(
        expierationMonthsController: _controllers.expirationMonths,
        numberOfCaloriesController: _controllers.numberOfCalories,
        unitAmountController: _controllers.unitAmount,
        descriptionController: _controllers.description,
        onFeaturedChanged: (v) => setState(() => _isFeatured = v),
        onOrganicChanged: (v) => setState(() => _isOrganic = v),
        requiredValidator: requiredValidator,
        numberValidator: priceValidator,
        quantityValidator: quantityValidator,
        initialFeatured: _isFeatured,
        initialOrganic: _isOrganic,
      ),
      2 => ReviewStep(
        productImage: _productImage,
        name: _controllers.name.text.trim(),
        code: _controllers.code.text.trim(),
        price: _controllers.price.text.trim(),
        quantity: _controllers.quantity.text.trim(),
        description: _controllers.description.text.trim(),
        isFeatured: _isFeatured,
        isOrganic: _isOrganic,
        expirationMonths: _controllers.expirationMonths.text.trim(),
        numberOfCalories: _controllers.numberOfCalories.text.trim(),
        unitAmount: _controllers.unitAmount.text.trim(),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
