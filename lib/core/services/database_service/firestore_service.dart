import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';

class FirestoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Query _applyQuery(Query base, Map<String, dynamic>? query) {
    if (query == null) return base;

    // ── where ────────────────────────────────────────────────────────────────
    if (query.containsKey('where')) {
      final clauses = query['where'] as List<Map<String, dynamic>>;
      for (final clause in clauses) {
        final field = clause['field'] as String;
        base = base.where(
          field,
          isEqualTo: clause['isEqualTo'],
          isNotEqualTo: clause['isNotEqualTo'],
          isLessThan: clause['isLessThan'],
          isLessThanOrEqualTo: clause['isLessThanOrEqualTo'],
          isGreaterThan: clause['isGreaterThan'],
          isGreaterThanOrEqualTo: clause['isGreaterThanOrEqualTo'],
          arrayContains: clause['arrayContains'],
          whereIn: clause['whereIn'] as List<dynamic>?,
          whereNotIn: clause['whereNotIn'] as List<dynamic>?,
          isNull: clause['isNull'] as bool?,
        );
      }
    }

    // ── orderBy ──────────────────────────────────────────────────────────────
    if (query.containsKey('orderBy')) {
      base = base.orderBy(
        query['orderBy'] as String,
        descending: query['descending'] as bool? ?? false,
      );
    }

    // ── limit ────────────────────────────────────────────────────────────────
    if (query.containsKey('limit')) {
      base = base.limit(query['limit'] as int);
    }

    return base;
  }

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
        final result = await _applyQuery(
          firestore.collection(path),
          query,
        ).get();
        return result.docs
            .map((e) => e.data() as Map<String, dynamic>)
            .toList();
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
    return _applyQuery(firestore.collection(path), query).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) {
        return builder(doc.data() as Map<String, dynamic>, doc.id);
      }).toList(),
    );
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
