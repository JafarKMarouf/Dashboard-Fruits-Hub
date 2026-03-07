import 'dart:developer';

import 'package:dashboard_fruit_hub/core/services/database_service/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStoreService extends DatabaseService {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      await supabase.from(path).insert(data);
    } catch (e) {
      log('Exception in SupastoreService.addData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  }) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<bool> isDataExists({
    required String path,
    required String documentId,
  }) {
    // TODO: implement isDataExists
    throw UnimplementedError();
  }
}
