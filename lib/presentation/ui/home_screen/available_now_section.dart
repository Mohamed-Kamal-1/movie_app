import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/home_screen_view_model.dart';

import '../../../core/colors/app_color.dart';

class AvailableNowSection extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const AvailableNowSection({
    super.key,
    required this.viewModel,
  });

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  final PageController _pageController = PageController(viewportFraction: 0.65);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
@override
  void initState() {
    super.initState();
  widget.viewModel.getMoviesList('2025-11-25');
  }
  @override
  Widget build(BuildContext context) {
    bool increment = false;
    bool decrement = false;


    return Column(
      children: [
        Expanded(child: Image.asset(AppImage.availableNow)),

        BlocBuilder<HomeScreenViewModel, HomeScreenState>(
          bloc: widget.viewModel,
          builder: (context, state) {

            if (state is HomeLoadingState) {
              return Expanded(flex: 4,child: Center(child: CircularProgressIndicator()));
            }

            if (state is HomeErrorState) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Error",
                  style: context.fonts.bodyMedium?.copyWith(
                    color: AppColor.white,
                  ),
                ),
              );
            }

            if (state is HomeSuccessState) {
              return Expanded(
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
                          imageUrl: state.moviesList![index].mediumCoverImage!,
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return SizedBox();
          },
        ),

        Flexible(child: Image.asset(AppImage.watchNow)),
      ],
    );
  }
}
