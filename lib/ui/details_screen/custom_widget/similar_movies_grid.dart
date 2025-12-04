import 'package:flutter/material.dart';
import 'package:movie_app/ui/details_screen/custom_widget/similar_movie_card.dart';

class SimilarMoviesGrid extends StatelessWidget {
  final List<dynamic> suggestions;
  final double width;
  final double height;

  const SimilarMoviesGrid({
    super.key,
    required this.suggestions,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding:  EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.03,
        mainAxisSpacing: height * 0.025,
        childAspectRatio: 1 / 1.6,
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return SimilarMovieCard(movie: movie);
      },
    );
  }
}
