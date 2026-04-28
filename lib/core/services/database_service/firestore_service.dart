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
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (documentId != null) {
        var data = await firestore.collection(path).doc(documentId).get();
        return data.data() as Map<String, dynamic>;
      } else {
        Query firestoreQuery = firestore.collection(path);

        if (query != null && query.containsKey('orderBy')) {
          firestoreQuery = firestoreQuery.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }

        if (query != null && query.containsKey('limit')) {
          firestoreQuery = firestoreQuery.limit(query['limit'] as int);
        }
        var data = await firestoreQuery.get();
        return data.docs.map((e) => e.data() as Map<String, dynamic>).toList();
      }
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

  @override
  Stream<List<T>> watchData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Map<String, dynamic>? query,
  }) {
    Query firestoreQuery = firestore.collection(path);

    if (query != null && query.containsKey('orderBy')) {
      firestoreQuery = firestoreQuery.orderBy(
        query['orderBy'],
        descending: query['descending'] ?? false,
      );
    }

    if (query != null && query.containsKey('limit')) {
      firestoreQuery = firestoreQuery.limit(query['limit'] as int);
    }

    return firestoreQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return builder(data, doc.id);
      }).toList();
    });
  }

  @override
  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).update(data);
    } on FirebaseException catch (e) {
      log('FirebaseException in FirestoreService.updateData: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Exception in FirestoreService.updateData: ${e.toString()}');
      rethrow;
    }
  }
}
