import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/mock_orders.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/build_action_buttons.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/build_header.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/build_recent_orders_header.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/build_stats_row.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/main_app_bar.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/views/dashboard/widgets/revenue_card.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/l10n/l10n.dart';
import '../../../../../../core/utils/constants.dart';
import 'animated_order_item.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody>
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

  List<OrderEntity> get _orders => MockOrders.recent;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
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

  Widget _animated(int sectionIndex, Widget child) {
    return FadeTransition(
      opacity: _fadeAnims[sectionIndex],
      child: SlideTransition(position: _slideAnims[sectionIndex], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            _buildHeader(),
            _buildRevenueCard(),
            _buildStatsRow(),
            _buildActionButtons(context),
            _buildRecentOrdersHeader(),
            _buildOrderList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() => SliverToBoxAdapter(
    child: Column(
      children: [
        const SizedBox(height: kTopPadding),
        _animated(
          0,
          MainAppBar(title: AppLocalizations.of(context).dashboardTitle),
        ),
      ],
    ),
  );

  Widget _buildHeader() => SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _animated(1, const BuildHeader()),
        const SizedBox(height: 24),
      ],
    ),
  );

  Widget _buildRevenueCard() =>
      SliverToBoxAdapter(child: _animated(2, const RevenueCard()));

  Widget _buildStatsRow() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _animated(3, const BuildStatsRow()),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _animated(4, const BuildActionButtons()),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersHeader() =>
      SliverToBoxAdapter(child: _animated(3, const BuildRecentOrdersHeader()));

  Widget _buildOrderList() => DecoratedSliver(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    sliver: SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final isLast = index == _orders.length - 1;
          return Column(
            children: [
              AnimatedOrderItem(
                key: ValueKey(_orders[index].id),
                order: _orders[index],
                entryController: _entryController,
                delayFraction: (0.55 + index * 0.08).clamp(0.0, 0.90),
              ),
              if (!isLast)
                const Divider(
                  height: 2,
                  indent: 16,
                  endIndent: 16,
                  color: Color(0xFFF3F4F6),
                ),
            ],
          );
        }, childCount: _orders.length),
      ),
    ),
  );
}
