import 'dart:io';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  });

  Future<bool> isDataExists({required String path, required String documentId});

  Future<String> uploadImage(File image, String bucket);
}
