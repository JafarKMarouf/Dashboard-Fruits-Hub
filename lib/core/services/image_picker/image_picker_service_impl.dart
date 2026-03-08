import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'image_picker_service.dart';

final class ImagePickerServiceImpl implements ImagePickerService {
  ImagePickerServiceImpl({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  static const int _imageQuality = 85;
  static const double _maxWidth = 1080;

  @override
  Future<File?> pickFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: _imageQuality,
        maxWidth: _maxWidth,
      );
      return picked != null ? File(picked.path) : null;
    } on Exception catch (e) {
      throw ImagePickerException(
        'Failed to pick image from gallery.',
        cause: e,
      );
    }
  }
}
