import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/styles/app_colors.dart';

class CustomersListLoading extends StatelessWidget {
  const CustomersListLoading({super.key, this.itemCount = 6});

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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(width: 20, height: 20, color: AppColors.grayscale100),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.grayscale100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 100,
                      height: 16,
                      color: AppColors.grayscale100,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  width: 160,
                  height: 12,
                  color: AppColors.grayscale100,
                ),
                const SizedBox(height: 6),
                Container(width: 80, height: 12, color: AppColors.grayscale100),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.grayscale100,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
