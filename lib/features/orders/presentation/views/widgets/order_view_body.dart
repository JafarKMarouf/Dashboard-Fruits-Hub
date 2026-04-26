import 'package:dashboard_fruit_hub/core/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/shared/widgets/main_app_bar.dart';
import '../../../domain/entities/order_entity.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';
import 'empty_orders.dart';
import 'order_card.dart';
import 'orders_filter_bar.dart';
import 'orders_stats_row.dart';

class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key});

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;

  late final List<Animation<double>> _fadeAnims;
  late final List<Animation<Offset>> _slideAnims;
  static const int _sectionCount = 5;
  static const List<(double, double)> _intervals = [
    (0.00, 0.30),
    (0.10, 0.38),
    (0.20, 0.50),
    (0.32, 0.62),
    (0.44, 0.74),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnims = List.generate(_sectionCount, (i) {
      final (begin, end) = _intervals[i];
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(begin, end, curve: Curves.easeOut),
        ),
      );
    });

    _slideAnims = List.generate(_sectionCount, (i) {
      final (begin, end) = _intervals[i];
      return Tween<Offset>(
        begin: const Offset(0, 0.18),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(begin, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  Widget _animated(int sectionIndex, Widget child) {
    return FadeTransition(
      opacity: _fadeAnims[sectionIndex],
      child: SlideTransition(position: _slideAnims[sectionIndex], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listenWhen: (_, current) => current is OrderStatusUpdateError,
      listener: (context, state) {
        if (state is OrderStatusUpdateError) {
          showErrorBar(context, 'فشل تحديث الطلب: ${state.message}');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── App bar ──────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: kTopPadding),
                      _animated(
                        0,
                        MainAppBar(
                          title: AppLocalizations.of(context).orderListTitle,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Stats row ────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnims[1],
                    child: _buildStatsRow(state),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── Filter bar ───────────────────────────────────────────
                SliverToBoxAdapter(child: _buildFilterBar(state)),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── Section title ────────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: AppTextWidget(
                      'أحدث الطلبات',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyles.styleBold16,
                    ),
                  ),
                ),

                // ── Orders list ──────────────────────────────────────────
                _buildOrdersList(state),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Stats ──────────────────────────────────────────────────────────────

  Widget _buildStatsRow(OrdersState state) {
    if (state is! OrdersLoaded) {
      return const OrdersStatsRow(total: 0, pending: 0, shipped: 0, revenue: 0);
    }
    final cubit = context.read<OrdersCubit>();
    final revenue = state.orders.fold<double>(0, (s, o) => s + o.finalTotal);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: OrdersStatsRow(
        total: state.orders.length,
        pending: cubit.countByStatus(OrderStatus.pending),
        shipped: cubit.countByStatus(OrderStatus.shipped),
        revenue: revenue,
      ),
    );
  }

  // ─── Filter bar ──────────────────────────────────────────────────────────

  Widget _buildFilterBar(OrdersState state) {
    final cubit = context.read<OrdersCubit>();
    final filter = state is OrdersLoaded ? state.activeFilter : OrderFilter.all;
    return OrdersFilterBar(
      activeFilter: filter,
      counts: {
        OrderFilter.all: state is OrdersLoaded ? state.orders.length : 0,
        OrderFilter.pending: cubit.countByStatus(OrderStatus.pending),
        OrderFilter.shipped: cubit.countByStatus(OrderStatus.shipped),
        OrderFilter.delivered: cubit.countByStatus(OrderStatus.delivered),
      },
      onFilterChanged: cubit.setFilter,
    );
  }

  // ─── List ─────────────────────────────────────────────────────────────────

  Widget _buildOrdersList(OrdersState state) {
    if (state is OrdersLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is OrdersError) {
      return SliverFillRemaining(
        child: Center(
          child: AppTextWidget(
            'حدث خطأ: ${state.message}',
            style: AppTextStyles.styleRegular16.copyWith(
              color: AppColors.error,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      );
    }

    final orders = state is OrdersLoaded
        ? state.filtered
        : (state is OrderStatusUpdateError ? state.filtered : <OrderEntity>[]);

    final updatingId = state is OrdersLoaded ? state.updatingOrderId : null;

    if (orders.isEmpty) {
      return const SliverFillRemaining(child: EmptyOrders());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final order = orders[index];
        return OrderCard(
          key: ValueKey(order.id),
          order: order,
          isUpdating: updatingId == order.id,
          onTap: () => _onOrderTap(order),
          onStatusChanged: (status) => context.read<OrdersCubit>().updateStatus(
            orderId: order.id,
            status: status,
          ),
        );
      }, childCount: orders.length),
    );
  }

  void _onOrderTap(OrderEntity order) {
    // Navigate to order detail — push route when implemented
    // Navigator.of(context).pushNamed(OrderDetailView.routeName, arguments: order.id);
  }
}
