import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/extention/error_extention.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/home_screen_view_model.dart';

import '../../../../../core/colors/app_color.dart';
import '../../widgets/home_shimmer_widget.dart';
import 'available_now/background_image.dart';
import 'available_now/image_slider.dart';

class AvailableNowSection extends StatefulWidget {
  const AvailableNowSection({super.key});

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  final ValueNotifier<int> currentPage = ValueNotifier(0);
  int? index = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    currentPage.dispose();
  }

  BoxDecoration gradientDecoration = BoxDecoration(
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
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeScreenViewModel>()..getMoviesList('2025-11-25'),
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const AvailableNowShimmer();
          }

          if (state is HomeErrorState) {
            return Center(
              child: Text(
                context.getErrorMessage(state.errorMessage),
                style: context.fonts.bodyMedium?.copyWith(color: AppColor.white),
              ),
            );
          }

          if (state is HomeSuccessState) {
            return Stack(
              children: [
                BackgroundImage(
                  currentPage: currentPage,
                  moviesList: state.moviesList ?? [],
                ), Container(
                  decoration: gradientDecoration,
                ),

                Column(
                  children: [
                    Expanded(child: Image.asset(AppImage.availableNow)),
                    Expanded(
                      flex: 3,
                      child: RepaintBoundary(
                        child: ImageSlider(
                          onScroll: (index) {
                            currentPage.value = index;
                          },
                          pageController: _pageController,
                          moviesList: state.moviesList ?? [],
                        ),
                      ),
                    ),
                    Flexible(child: Image.asset(AppImage.watchNow)),
                  ],
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
