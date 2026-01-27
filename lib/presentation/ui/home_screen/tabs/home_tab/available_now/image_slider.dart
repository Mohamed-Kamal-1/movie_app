import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';

import '../../../../../../core/colors/app_color.dart';
import '../../../../../../domain/model/movie_model.dart';

typedef OnScroll = Function(int index);

class ImageSlider extends StatelessWidget {
  final PageController pageController;
  final OnScroll onScroll;
  final List<MovieModel> moviesList;

  const ImageSlider({
    super.key,
    required this.moviesList,
    required this.onScroll,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (value) {
        onScroll(value);
      },
      controller: pageController,
      itemCount: moviesList.length,
      itemBuilder: (context, index) {
        if (index >= moviesList.length) {
          return const SizedBox.shrink();
        }

        return AnimatedBuilder(
          animation: pageController,

          builder: (context, child) {
            double value = 1;
            if (pageController.position.haveDimensions) {
              value = (pageController.page! - index).abs();
              value = (1 - value * 0.3).clamp(0.8, 1.0);
            }
            return Transform.scale(scale: value, child: child);
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          movieId: moviesList[index].id?.toInt() ?? 0,
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    memCacheHeight: 400,
                    memCacheWidth: 400,

                    fit: BoxFit.fill,
                    imageUrl: moviesList[index].mediumCoverImage ?? "",


                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              // RatingWidget(movieId: moviesList[index].imdbCode ?? '0'),
            ],
          ),
        );
      },
    );
  }
}
