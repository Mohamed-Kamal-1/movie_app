import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/home_screen_view_model.dart';

import '../../../../../core/colors/app_color.dart';

class AvailableNowSection extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const AvailableNowSection({super.key, required this.viewModel});

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  final ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    currentPage.dispose();
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.hasClients && _pageController.page != null) {
        currentPage.value = _pageController.page!.round();
      }
    });

    widget.viewModel.getMoviesList('2025-11-25');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenState>(
      bloc: widget.viewModel,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Expanded(
            flex: 4,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeErrorState) {
          return Center(
            child: Text(
              state.errorMessage ?? "Error",
              style: context.fonts.bodyMedium?.copyWith(color: AppColor.white),
            ),
          );
        }

        if (state is HomeSuccessState) {
          return Stack(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: currentPage,
                builder: (context, value, child) {
                  return Positioned.fill(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: state.moviesList![value].largeCoverImage ?? "",

                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),

                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
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

              Column(
                children: [
                  Expanded(child: Image.asset(AppImage.availableNow)),
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.moviesList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1;
                            if (_pageController.position.haveDimensions) {
                              value = (_pageController.page! - index).abs();
                              value = (1 - value * 0.3).clamp(0.8, 1.0);
                            }
                            return Transform.scale(scale: value, child: child);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                                  state.moviesList![index].mediumCoverImage ??
                                  "",
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),

                              errorWidget: (context, url, error) => Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
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
    );
  }
}
