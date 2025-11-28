import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/l10n/app_string.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/search_tab/search_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/watch_now_section.dart';

import 'available_now_section.dart';
import 'bottom_navigation_section.dart';
import '../../cubit/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenViewModel viewModel;

  HomeScreen({super.key, required this.viewModel});

  final List<String> images = [
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: AvailableNowSection(viewModel: viewModel)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(AppString.action, style: context.fonts.titleMedium),
              const Spacer(),

              GestureDetector(
                onTap: () {
                  Feedback.forTap(context);
                },
                child: Row(
                  spacing: 6,
                  children: [
                    Text(
                      AppString.seeMore,
                      style: context.fonts.titleSmall?.copyWith(
                        color: AppColor.yellow,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: AppColor.yellow),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          width: double.infinity,
          child: WatchNowSection(images: images),
        ),
      ],
    );
  }
}
