import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repos/orders_repo.dart';
import '../models/order_model.dart';

class OrdersRepoImpl implements OrdersRepo {
  final FirebaseFirestore _firestore;

  OrdersRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;
  static const int _pageLimit = 20;

  Future<String> _fetchUserName(String userId) async {
    if (userId.isEmpty) return '';
    try {
      final doc = await _firestore
          .collection(BackendEndpoints.getUser)
          .doc(userId)
          .get();
      return doc.data()?['name'] as String? ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<OrderModel> _enrichOrder(DocumentSnapshot doc) async {
    final order = OrderModel.fromDoc(doc);
    final customerName = await _fetchUserName(order.userId);
    return customerName.isNotEmpty
        ? order.copyWith(customerName: customerName)
        : order;
  }

  @override
  Stream<List<OrderEntity>> watchOrders() {
    return _firestore
        .collection(BackendEndpoints.getOrder)
        .orderBy('created_at', descending: true)
        .limit(_pageLimit)
        .snapshots()
        .asyncMap((snap) => Future.wait(snap.docs.map(_enrichOrder)));
  }

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    final doc = await _firestore
        .collection(BackendEndpoints.getOrder)
        .doc(orderId)
        .get();
    if (!doc.exists) throw Exception('Order $orderId not found');
    return _enrichOrder(doc);
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    await _firestore.collection(BackendEndpoints.getOrder).doc(orderId).update({
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
