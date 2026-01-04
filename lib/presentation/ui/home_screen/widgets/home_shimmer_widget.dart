import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/colors/app_color.dart';

class AvailableNowShimmer extends StatelessWidget {
  const AvailableNowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.gray.withOpacity(0.3),
      highlightColor: AppColor.white.withOpacity(0.1),
      child: Stack(
        children: [
          // Background image placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColor.gray,
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.47, 1],
                colors: [
                  const Color(0xFF121312).withOpacity(0.45),
                  const Color(0xFF121312).withOpacity(0.6),
                  const Color(0xFF121312).withOpacity(1),
                ],
              ),
            ),
          ),
          Column(
            children: [
              // Available Now image placeholder
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              // PageView placeholder
              Expanded(
                flex: 3,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),
              // Watch Now image placeholder
              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WatchNowShimmer extends StatelessWidget {
  const WatchNowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.gray.withOpacity(0.3),
      highlightColor: AppColor.offWhite.withOpacity(0.1),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}

