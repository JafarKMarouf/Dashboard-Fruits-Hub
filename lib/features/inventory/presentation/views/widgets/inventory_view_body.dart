import 'package:dashboard_fruit_hub/core/utils/helpers/build_messages_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/custom_error_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/main_app_bar.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants.dart';
import '../../manager/inventory_cubit/inventory_cubit.dart';
import 'inventory_card.dart';
import 'inventory_list_loading.dart';
import 'inventory_search_bar.dart';

class InventoryViewBody extends StatefulWidget {
  const InventoryViewBody({super.key});

  @override
  State<InventoryViewBody> createState() => _InventoryViewBodyState();
}

class _InventoryViewBodyState extends State<InventoryViewBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final hasFocus = FocusScope.of(context).hasFocus;
    if (hasFocus) FocusScope.of(context).unfocus();
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
            child: CustomScrollView(
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                // ── App Bar ──────────────────────────────────────────────────
                const SliverToBoxAdapter(
                  child: MainAppBar(title: 'إدارة المخزون'),
                ),
                const SliverToBoxAdapter(
                  child: Divider(color: AppColors.grayscale200),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 6)),

                // ── Search bar (sticky) ──────────────────────────────────────
                const SliverToBoxAdapter(child: InventorySearchBar()),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                // ── Content ──────────────────────────────────────────────────
                BlocConsumer<InventoryCubit, InventoryState>(
                  listener: (context, state) {
                    if (state is InventoryRestockFailureState) {
                      showErrorBar(context, 'فشل تحديث المخزون، حاول مجدداً');
                    }
                  },
                  builder: (context, state) {
                    if (state is InventoryLoadingState ||
                        state is InventoryInitialState) {
                      return const InventoryListLoading();
                    }

                    if (state is InventoryFailureState) {
                      return SliverFillRemaining(
                        child: CustomErrorWidget(
                          errorMessage: state.message,
                          onRetry: () =>
                              context.read<InventoryCubit>().startWatching(),
                        ),
                      );
                    }

                    if (state is InventoryLoadedState) {
                      if (state.products.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: AppTextWidget('لا توجد منتجات مطابقة'),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => InventoryCard(
                            key: ValueKey(state.products[index].id),
                            product: state.products[index],
                          ),
                          childCount: state.products.length,
                        ),
                      );
                    }

                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
