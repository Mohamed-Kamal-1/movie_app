import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/model/movie_model.dart';

class BackgroundImage extends StatelessWidget {
  final List<MovieModel> moviesList;
  final ValueNotifier<int> currentPage;

  const BackgroundImage({
    super.key,
    required this.currentPage,
    required this.moviesList,
  });

  @override
  Widget build(BuildContext context) {
    if (moviesList.isEmpty) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (context, value, child) {
        return Positioned.fill(
          child: CachedNetworkImage(
            memCacheHeight: 400,
            memCacheWidth: 400,
            fit: BoxFit.fill,
            imageUrl: moviesList[value].smallCoverImage ?? "",
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          ),
        );
      },
    );
  }
}
