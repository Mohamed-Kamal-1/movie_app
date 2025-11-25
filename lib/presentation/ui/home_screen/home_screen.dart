import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/l10n/app_string.dart';
import 'package:movie_app/presentation/ui/home_screen/watch_now_section.dart';

import 'available_now_section.dart';
import 'bottom_navigation_section.dart';
import 'cubit/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenViewModel viewModel;

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
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeScreenViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigationSection(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(AppImage.midImage, fit: BoxFit.fill),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.47, 1],
                      colors: [
                        const Color(0xFF121312).withValues(alpha: 0.45),
                        const Color(0xFF121312).withValues(alpha: 0.6),
                        const Color(0xFF121312).withValues(alpha: 1),
                      ],
                    ),
                  ),
                ),

                AvailableNowSection(viewModel: viewModel),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Text(AppString.action, style: context.fonts.titleMedium),
                    const Spacer(),
                    Text(
                      AppString.seeMore,
                      style: context.fonts.titleSmall?.copyWith(
                        color: AppColor.yellow,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward, color: AppColor.yellow),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                width: double.infinity,
                child: WatchNowSection(images: images),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
