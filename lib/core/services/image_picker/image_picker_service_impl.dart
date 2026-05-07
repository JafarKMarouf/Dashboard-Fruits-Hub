import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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

      return picked != null ? _copyToStableDir(picked) : null;
    } on Exception catch (e) {
      throw ImagePickerException(
        'Failed to pick image from gallery.',
        cause: e,
      );
    }
  }

  Future<File> _copyToStableDir(XFile picked) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(picked.path)}';
    final destPath = p.join(appDir.path, 'picked_images', fileName);

    // Create sub-directory if it doesn't exist yet
    await Directory(p.dirname(destPath)).create(recursive: true);

    // Copy from the volatile cache path → stable documents path
    return File(picked.path).copy(destPath);
  }
}
