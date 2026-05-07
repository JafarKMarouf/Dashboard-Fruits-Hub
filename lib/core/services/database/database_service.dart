abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Stream<List<T>> watchData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Map<String, dynamic>? query,
  });

  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<bool> isDataExists({required String path, required String documentId});
}
