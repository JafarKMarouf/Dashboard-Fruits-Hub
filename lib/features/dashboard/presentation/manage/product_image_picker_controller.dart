import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../../core/services/image_picker/image_picker_service.dart';

final class ProductImagePickerController extends ChangeNotifier {
  ProductImagePickerController({required ImagePickerService imagePickerService})
    : _imagePickerService = imagePickerService;

  final ImagePickerService _imagePickerService;

  File? _image;
  bool _isLoading = false;
  String? _errorMessage;

  File? get image => _image;
  bool get isLoading => _isLoading;
  bool get hasImage => _image != null;
  String? get errorMessage => _errorMessage;

  Future<void> pickImage() async {
    _setLoading(true);
    _clearError();

    try {
      final File? picked = await _imagePickerService.pickFromGallery();
      if (picked == null) return;
      _image = picked;
    } on ImagePickerException catch (e) {
      _errorMessage = e.message;
    } finally {
      _setLoading(false);
    }
  }

  void removeImage() {
    _image = null;
    _clearError();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() => _errorMessage = null;
}
