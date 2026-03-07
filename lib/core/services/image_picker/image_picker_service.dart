import 'dart:io';

abstract interface class ImagePickerService {
  Future<File?> pickFromGallery();
}

final class ImagePickerException implements Exception {
  const ImagePickerException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'ImagePickerException: $message${cause != null ? ' (cause: $cause)' : ''}';
}
