// Mock data
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_entity.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_status.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/shipping_address_entity.dart';

class MockOrders {
  static const List<OrderEntity> recent = [
    OrderEntity(
      id: '#23401',
      status: OrderStatus.pending,
      finalTotal: 45.23,
      shippingAddress: ShippingAddressEntity(name: 'Alice'),
    ),
    OrderEntity(
      id: '#23400',
      shippingAddress: ShippingAddressEntity(name: 'John D.'),
      finalTotal: 22.50,
      status: OrderStatus.shipped,
    ),
    OrderEntity(
      id: '#23399',
      shippingAddress: ShippingAddressEntity(name: 'Sarah K.'),
      finalTotal: 22.50,
      status: OrderStatus.delivered,
    ),
  ];
}
