import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/styles/app_colors.dart';

class InventoryListLoading extends StatelessWidget {
  const InventoryListLoading({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, _) => const Skeletonizer(
          enabled: true,
          effect: ShimmerEffect(
            baseColor: AppColors.grayscale100,
            highlightColor: AppColors.grayscale50,
            duration: Duration(milliseconds: 1200),
          ),
          child: _FakeCard(),
        ),
        childCount: itemCount,
      ),
    );
  }
}

class _FakeCard extends StatelessWidget {
  const _FakeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.grayscale100,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 120,
                      color: AppColors.grayscale100,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 80,
                      color: AppColors.grayscale100,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 24,
                      width: 140,
                      color: AppColors.grayscale100,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grayscale100,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
