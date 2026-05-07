import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.onCleared,
    this.debounceDuration = const Duration(milliseconds: 350),
  });

  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onCleared;
  final Duration debounceDuration;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
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
    _debounce = Timer(widget.debounceDuration, () {
      if (!mounted) return;
      widget.onChanged(value);
    });
  }

  void _onClear() {
    _controller.clear();
    _debounce?.cancel();
    widget.onCleared();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: widget.hint,
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
              onPressed: _onClear,
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
