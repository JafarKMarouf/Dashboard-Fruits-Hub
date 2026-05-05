import 'package:dashboard_fruit_hub/core/enums/order_status.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/shipping_address_entity.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/entities/order_entity/order_entity.dart';
import '../../../../../core/entities/order_entity/order_item_entity.dart';
import 'order_card.dart';

class OrdersListLoading extends StatelessWidget {
  final int itemCount;

  const OrdersListLoading({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, _) => Skeletonizer(
          enabled: true,
          effect: const ShimmerEffect(
            baseColor: AppColors.grayscale100,
            highlightColor: AppColors.grayscale50,
            duration: Duration(milliseconds: 1200),
          ),
          child: OrderCard(
            order: _fakeOrder,
            isUpdating: false,
            onTap: () {},
            onStatusChanged: (_) {},
          ),
        ),
        childCount: itemCount,
      ),
    );
  }
}

final _fakeOrder = OrderEntity(
  id: 'XXXX',
  items: List.generate(
    3,
    (i) => OrderItemEntity(
      productCode: 'p$i',
      productName: 'منتج',
      imageUrl: null,
      quantity: 2,
      priceAtPurchase: 25.0,
    ),
  ),
  status: OrderStatus.pending,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  userId: '',
  payMethod: '',
  shippingAddress: const ShippingAddressEntity(
    name: 'Jafar Marouf',
    phone: '05XXXXXXXX',
    email: 'email@example.com',
    city: 'Homs',
    state: 'Homs',
  ),
  totalPrice: 125.50,
  finalTotal: 130.0,
);
