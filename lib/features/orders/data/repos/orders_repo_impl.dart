import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_status.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repos/orders_repo.dart';
import '../models/order_model.dart';

class OrdersRepoImpl implements OrdersRepo {
  final FirebaseFirestore _firestore;

  OrdersRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;
  static const int _pageLimit = 20;

  @override
  Stream<List<OrderEntity>> watchOrders() {
    return _firestore
        .collection(BackendEndpoints.getOrder)
        .orderBy('created_at', descending: true)
        .limit(_pageLimit)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((order) => OrderModel.fromDoc(order).toEntity())
              .toList(),
        );
  }

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    final doc = await _firestore
        .collection(BackendEndpoints.getOrder)
        .doc(orderId)
        .get();
    if (!doc.exists) throw Exception('Order $orderId not found');
    return OrderModel.fromDoc(doc).toEntity();
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    await _firestore.collection(BackendEndpoints.getOrder).doc(orderId).update({
      'status': status.name,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
