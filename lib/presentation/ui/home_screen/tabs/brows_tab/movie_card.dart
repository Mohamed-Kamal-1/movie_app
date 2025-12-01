import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../../../../core/colors/app_color.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navigate to movie details
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Poster Image
            Image.network(
              movie.mediumCoverImage ?? movie.largeCoverImage ?? "",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.black26,
                child: Center(
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white12,
                    size: 40,
                  ),
                ),
              ),
            ),

            // Rating badge (top-left)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating?.toString() ?? "N/A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: AppColor.yellow, size: 16),
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
