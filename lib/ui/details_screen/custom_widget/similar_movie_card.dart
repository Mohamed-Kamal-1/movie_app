import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/styles/app_styles.dart';
import '../details_screen.dart';

class SimilarMovieCard extends StatelessWidget {
  final dynamic movie;
  const SimilarMovieCard({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: movie.id.toString(),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: movie.largeCoverImage ??
                  movie.mediumCoverImage ??
                  movie.smallCoverImage ??
                  "",
              fit:  BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppColor.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating?.toStringAsFixed(1) ?? "0",
                      style: AppStyles.regular16White.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
