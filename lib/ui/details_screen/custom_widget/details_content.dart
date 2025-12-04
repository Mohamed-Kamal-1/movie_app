import 'package:flutter/material.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/custom_widget/screenshot_image.dart';
import 'package:movie_app/ui/details_screen/custom_widget/similar_movies_grid.dart';
import 'package:movie_app/ui/details_screen/widgets/movie_details_widget.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:readmore/readmore.dart';

import '../../../core/colors/app_color.dart';
import '../widgets/details_shimmer_widget.dart';
import 'cast_list.dart';
import 'genres_wrap.dart';

class DetailsContent extends StatelessWidget {
  final dynamic movieDetails;
  final List<dynamic> suggestions;
  final DetailsScreenViewModel viewModel;
  final bool isLoadingSuggestions;

  const DetailsContent({
    super.key,
    required this.movieDetails,
    required this.suggestions,
    required this.viewModel,
    required this.isLoadingSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          MovieDetailsWidget(movieDetails: movieDetails, viewModel: viewModel),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.02),
                if (movieDetails.largeScreenshotImage1 != null ||
                    movieDetails.largeScreenshotImage2 != null ||
                    movieDetails.largeScreenshotImage3 != null) ...[
                  Text('Screen Shots', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  if (movieDetails.largeScreenshotImage1 != null)
                    ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage1!,
                    ),
                  if (movieDetails.largeScreenshotImage2 != null) ...[
                    SizedBox(height: height * 0.015),
                    ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage2!,
                    ),
                  ],
                  if (movieDetails.largeScreenshotImage3 != null) ...[
                    SizedBox(height: height * 0.015),
                    ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage3!,
                    ),
                  ],
                  SizedBox(height: height * 0.02),
                ],
                if (isLoadingSuggestions) ...[
                  const SuggestionsShimmerWidget(),
                  SizedBox(height: height * 0.02),
                ] else if (suggestions.isNotEmpty) ...[
                  Text('Similar', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  SimilarMoviesGrid(
                    suggestions: suggestions,
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: height * 0.02),
                ],
                Text('Description', style: AppStyles.bold24White),
                SizedBox(height: height * 0.02),
                ReadMoreText(
                  movieDetails.descriptionFull?.isNotEmpty == true
                      ? movieDetails.descriptionFull!
                      : 'No Description Available...',
                  trimMode: TrimMode.Line,
                  trimLines: 5,
                  colorClickableText: AppColor.yellow,
                  trimCollapsedText: 'See More',
                  trimExpandedText: ' See Less',
                  moreStyle: AppStyles.regular16Yellow,
                  style: AppStyles.regular16White,
                ),
                if (movieDetails.cast != null &&
                    movieDetails.cast!.isNotEmpty) ...[
                  SizedBox(height: height * 0.02),
                  Text('Cast', style: AppStyles.bold24White),
                  CastList(
                    cast: movieDetails.cast!,
                    width: width,
                    height: height,
                  ),
                ],
                if (movieDetails.genres != null &&
                    movieDetails.genres!.isNotEmpty) ...[
                  SizedBox(height: height * 0.02),
                  Text('Genres', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  GenresWrap(
                    genres: movieDetails.genres!,
                    width: width,
                    height: height,
                  ),
                ],
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
