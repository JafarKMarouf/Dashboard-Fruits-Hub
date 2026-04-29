import 'dart:async';

import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../manager/inventory_cubit/inventory_cubit.dart';

class InventorySearchBar extends StatefulWidget {
  const InventorySearchBar({super.key});

  @override
  State<InventorySearchBar> createState() => _InventorySearchBarState();
}

class _InventorySearchBarState extends State<InventorySearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<InventoryCubit>().search(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: 'ابحث عن منتج...',
        hintStyle: AppTextStyles.styleBold14.copyWith(
          color: AppColors.grayscale500,
        ),
        hintTextDirection: TextDirection.rtl,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.primaryDark,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (_, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: () {
                _controller.clear();
                context.read<InventoryCubit>().clearSearch();
              },
            );
          },
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            width: 1.2,
            color: AppColors.primary.withOpacity(.7),
          ),
        ),
      ),
    );
  }
}
