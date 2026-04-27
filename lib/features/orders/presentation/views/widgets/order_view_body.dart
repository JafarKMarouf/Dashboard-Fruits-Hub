import 'package:dashboard_fruit_hub/core/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_status.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/views/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/shared/widgets/main_app_bar.dart';
import '../../../domain/entities/order_entity.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';
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

  late final List<Animation<double>> _fadeAnimation;
  late final List<Animation<Offset>> _slideAnimation;
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

    _fadeAnimation = List.generate(_sectionCount, (i) {
      final (begin, end) = _intervals[i];
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(begin, end, curve: Curves.easeOut),
        ),
      );
    });

    _slideAnimation = List.generate(_sectionCount, (i) {
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
      opacity: _fadeAnimation[sectionIndex],
      child: SlideTransition(
        position: _slideAnimation[sectionIndex],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listenWhen: (_, current) => current is OrderStatusUpdateError,
      listener: (context, state) {
        if (state is OrderStatusUpdateError) {
          showErrorBar(context, 'فشل تحديث الطلب: ${state.message}');
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
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
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation[1],
                  child: const _OrdersStats(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              const SliverToBoxAdapter(child: _OrdersFilter()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'أحدث الطلبات',
                    textDirection: TextDirection.rtl,
                    style: AppTextStyles.styleBold16,
                  ),
                ),
              ),
              OrdersList(onOrderTap: _onOrderTap),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  void _onOrderTap(OrderEntity order) {
    // Navigator.of(context).pushNamed(
    //   OrderDetailView.routeName,
    //   arguments: order.id,
    // );
  }
}

class _OrdersStats extends StatelessWidget {
  const _OrdersStats();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (_, curr) => curr is OrdersLoaded,
      builder: (context, state) {
        if (state is! OrdersLoaded) {
          return const OrdersStatsRow(
            total: 0,
            pending: 0,
            shipped: 0,
            revenue: 0,
          );
        }
        final cubit = context.read<OrdersCubit>();
        final revenue = state.orders.fold<double>(
          0,
          (s, o) => s + o.finalTotal,
        );
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OrdersStatsRow(
            total: state.orders.length,
            pending: cubit.countByStatus(OrderStatus.pending),
            shipped: cubit.countByStatus(OrderStatus.shipped),
            revenue: revenue,
          ),
        );
      },
    );
  }
}

class _OrdersFilter extends StatelessWidget {
  const _OrdersFilter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (prev, curr) =>
          curr is OrdersLoaded &&
          (prev is! OrdersLoaded || (prev).activeFilter != (curr).activeFilter),
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final filter = state is OrdersLoaded
            ? state.activeFilter
            : OrderFilter.all;
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
      },
    );
  }
}
