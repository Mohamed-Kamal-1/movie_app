import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../core/colors/app_color.dart';

class MoviesWidget extends StatefulWidget {
  final List<MovieModel> movies;

  const MoviesWidget({
    super.key, required this.movies});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            itemCount: widget.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 8,
              childAspectRatio: 1 / 1.5,
            ),

            itemBuilder: (context, index) {
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.movies[index].mediumCoverImage ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    ),

                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.symmetric(
                  //     vertical: 13,
                  //     horizontal: 10.11,
                  //   ),
                  //   padding: EdgeInsetsDirectional.all(6),
                  //   alignment: Alignment.center,
                  //   clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //     color: AppColor.black.withAlpha(171),
                  //     borderRadius: BorderRadiusGeometry.circular(10),
                  //   ),
                  //   width: 62,
                  //   height: 30,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(widget.rating ?? '7.7', style: context.fonts.titleSmall),
                  //       Icon(Icons.star, color: AppColor.goldenYellow),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
