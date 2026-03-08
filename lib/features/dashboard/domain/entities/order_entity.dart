enum OrderStatus { pending, shipped, delivered }

class OrderEntity {
  final String id;
  final String customerName;
  final double amount;
  final OrderStatus status;

  const OrderEntity({
    required this.id,
    required this.customerName,
    required this.amount,
    required this.status,
  });

  String get statusAr {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.shipped:
        return 'تم الشحن';
      case OrderStatus.delivered:
        return 'تم التسليم';
    }
  }
}

// Mock data
class MockOrders {
  static const List<OrderEntity> recent = [
    OrderEntity(
      id: '#23401',
      customerName: 'Alice M.',
      amount: 45.20,
      status: OrderStatus.pending,
    ),
    OrderEntity(
      id: '#23400',
      customerName: 'John D.',
      amount: 22.50,
      status: OrderStatus.shipped,
    ),
    OrderEntity(
      id: '#23399',
      customerName: 'Sarah K.',
      amount: 67.00,
      status: OrderStatus.delivered,
    ),
    OrderEntity(
      id: '#23401',
      customerName: 'Alice M.',
      amount: 45.20,
      status: OrderStatus.pending,
    ),
    OrderEntity(
      id: '#23401',
      customerName: 'Alice M.',
      amount: 45.20,
      status: OrderStatus.pending,
    ),
    OrderEntity(
      id: '#23401',
      customerName: 'Alice M.',
      amount: 45.20,
      status: OrderStatus.pending,
    ),
  ];
}
