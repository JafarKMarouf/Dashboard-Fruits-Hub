import 'package:dashboard_fruit_hub/core/utils/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/views/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/entities/order_entity/order_entity.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/utils/shared/widgets/main_app_bar.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';
import 'orders_filter_bar.dart';
import 'orders_stats.dart';

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
    context.read<OrdersCubit>().startWatching();
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

  Widget _animated(int i, Widget child) => FadeTransition(
    opacity: _fadeAnimation[i],
    child: SlideTransition(position: _slideAnimation[i], child: child),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listenWhen: (_, current) => current is OrdersUpdateFailureState,
      listener: (context, state) {
        if (state is OrdersUpdateFailureState) {
          showErrorBar(context, 'فشل تحديث الطلب: ${state.errorMessage}');
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── App bar ───────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: _animated(
                    0,
                    MainAppBar(
                      title: AppLocalizations.of(context).orderListTitle,
                    ),
                  ),
                ),

                // ── Stats header ──────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation[1],
                    child: const OrdersStats(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                const SliverToBoxAdapter(child: OrdersFilterBar()),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── Section label ─────────────────────────────────────────────
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

                // ── Orders list ───────────────────────────────────────────────
                OrdersList(onOrderTap: _onOrderTap),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
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
