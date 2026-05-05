import 'package:dashboard_fruit_hub/core/utils/constants.dart';
import 'package:dashboard_fruit_hub/core/utils/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/custom_error_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/main_app_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/views/widgets/customers_card.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customers_filter_bar.dart';
import 'customers_list_loading.dart';
import 'customers_search_bar.dart';
import 'customers_stats_header.dart';

class CustomersViewBody extends StatefulWidget {
  const CustomersViewBody({super.key});

  @override
  State<CustomersViewBody> createState() => _CustomersViewBodyState();
}

class _CustomersViewBodyState extends State<CustomersViewBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: BlocConsumer<CustomersCubit, CustomersState>(
              listener: (context, state) {
                if (state is CustomersUpdateFailureState) {
                  showErrorBar(context, 'فشل تحديث حالة المستخدم، حاول مجدداً');
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // ── App Bar ─────────────────────────────────────────────
                    const SliverToBoxAdapter(
                      child: MainAppBar(title: 'إدارة المستخدمين'),
                    ),
                    const SliverToBoxAdapter(
                      child: Divider(color: AppColors.grayscale200),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 6)),

                    // ── Search bar ──────────────────────────────────────────
                    const SliverToBoxAdapter(child: CustomersSearchBar()),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),

                    // ── Filter chips ────────────────────────────────────────
                    const SliverToBoxAdapter(child: CustomersFilterBar()),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),

                    // ── Stats header ────────────────────────────────────────
                    if (state is CustomersLoadedState)
                      SliverToBoxAdapter(
                        child: CustomersStatsHeader(state: state),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 8)),

                    // ── Content ─────────────────────────────────────────────
                    _buildContent(context, state),

                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CustomersState state) {
    if (state is CustomersLoadingState || state is CustomersInitialState) {
      return const CustomersListLoading();
    }

    if (state is CustomersFailureState) {
      return SliverFillRemaining(
        child: CustomErrorWidget(
          errorMessage: state.message,
          onRetry: () => context.read<CustomersCubit>()..startWatching(),
        ),
      );
    }

    if (state is CustomersLoadedState) {
      if (state.customers.isEmpty) {
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyView(emptyMessage: 'لا يوجد مستخدمون مطابقون'),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CustomerCard(
            key: ValueKey(state.customers[index].id),
            customer: state.customers[index],
          ),
          childCount: state.customers.length,
        ),
      );
    }

    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
