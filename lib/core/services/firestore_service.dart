import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';

class FirestoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } on FirebaseException catch (e) {
      log('FirebaseException in FirestoreService.addData: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Exception in FirestoreService.addData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  }) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      log('FirebaseException in FirestoreService.getData: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Exception in FirestoreService.getData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<bool> isDataExists({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
