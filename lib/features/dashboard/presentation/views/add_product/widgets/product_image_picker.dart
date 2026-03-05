import 'dart:io';

import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker({super.key, required this.onImageSelected});

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
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1080,
      );

      if (picked != null) {
        final file = File(picked.path);
        setState(() => _pickedImage = file);
        widget.onImageSelected(file);
      }
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
              : AppColors.secondaryLight.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _pickedImage != null
                ? AppColors.secondary
                : AppColors.secondary.withOpacity(0.4),
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
                _OverlayIconButton(
                  icon: Icons.edit_rounded,
                  onTap: _pickFromGallery,
                ),
                const SizedBox(width: 6),
                _OverlayIconButton(
                  icon: Icons.delete_rounded,
                  onTap: _removeImage,
                  color: AppColors.error,
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
            color: AppColors.secondary,
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
            color: AppColors.secondary.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add_a_photo_rounded,
            color: AppColors.secondary,
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

// ─────────────────────────────────────────────────────────────────────────────
// _OverlayIconButton — small frosted icon button shown on the image preview
// ─────────────────────────────────────────────────────────────────────────────

class _OverlayIconButton extends StatelessWidget {
  const _OverlayIconButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color ?? Colors.white, size: 16),
      ),
    );
  }
}
