import 'dart:developer';
import 'dart:io';

import 'package:dashboard_fruit_hub/core/services/storage/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage extends StorageService {
  final supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File image, String bucket) async {
    try {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';

      final String storagePath = 'images/$fileName';
      final bytes = await image.readAsBytes();

      await supabase.storage
          .from(bucket)
          .uploadBinary(
            storagePath,
            bytes,
            fileOptions: const FileOptions(upsert: false),
          );

      return supabase.storage.from(bucket).getPublicUrl(storagePath);
    } on StorageException catch (e) {
      log('StorageException in SupabaseStorage.uploadImage: ${e.message}');
      rethrow;
    } catch (e) {
      log('Exception in SupabaseStorage.uploadImage: $e');
      rethrow;
    }
  }
}
