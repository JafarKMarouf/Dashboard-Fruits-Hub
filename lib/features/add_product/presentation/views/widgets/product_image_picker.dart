import 'dart:io';

import 'package:dashboard_fruit_hub/core/utils/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/image_picker/image_picker_service.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import 'overlay_icon_button.dart';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker({
    super.key,
    required this.imagePickerService,
    required this.onImageSelected,
  });

  final ImagePickerService imagePickerService;
  final ValueChanged<File?> onImageSelected;

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? _pickedImage;
  bool _isLoading = false;

  // ── image picker ────────────────────────────────────────────────────────────

  Future<void> _pickFromGallery() async {
    setState(() => _isLoading = true);

    try {
      final File? picked = await widget.imagePickerService.pickFromGallery();
      if (picked == null) return;

      final file = File(picked.path);
      setState(() => _pickedImage = file);
      widget.onImageSelected(file);
    } on ImagePickerException catch (e) {
      if (!mounted) return;
      showErrorBar(context, e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _removeImage() {
    setState(() => _pickedImage = null);
    widget.onImageSelected(null);
  }

  // ── build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _pickFromGallery,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 175,
        decoration: BoxDecoration(
          color: _pickedImage != null
              ? Colors.transparent
              : AppColors.primaryDark.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _pickedImage != null
                ? AppColors.primaryDark
                : AppColors.primaryDark.withOpacity(0.4),
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: _pickedImage != null ? _buildPreview() : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(_pickedImage!, fit: BoxFit.cover),
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                OverlayIconButton(
                  icon: Icons.edit_rounded,
                  onTap: _pickFromGallery,
                ),
                const SizedBox(width: 6),
                OverlayIconButton(
                  icon: Icons.delete_rounded,
                  onTap: _removeImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    if (_isLoading) {
      return const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primaryDark,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primaryDark.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add_a_photo_rounded,
            color: AppColors.primaryDark,
            size: 26,
          ),
        ),
        const SizedBox(height: 12),
        AppTextWidget(
          'صورة المنتج',
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.grayscale800,
          ),
        ),
        const SizedBox(height: 4),
        AppTextWidget(
          'اضغط هنا لرفع صورة عالية الجودة\nللمنتج (PNG, JPG)',
          textAlign: TextAlign.center,

          style: AppTextStyles.styleRegular13.copyWith(
            color: AppColors.grayscale400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
