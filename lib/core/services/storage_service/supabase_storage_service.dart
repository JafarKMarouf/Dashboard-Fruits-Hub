import 'dart:io';

import 'package:dashboard_fruit_hub/core/services/storage_service/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService extends StorageService {
  final supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File image, String bucket) async {
    final String fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';

    final String storagePath = 'images/$fileName';

    await supabase.storage
        .from(bucket)
        .upload(
          storagePath,
          image,
          fileOptions: const FileOptions(upsert: false),
        );

    return supabase.storage.from(bucket).getPublicUrl(storagePath);
  }
}
