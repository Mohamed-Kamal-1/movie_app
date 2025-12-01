import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/extensions/extension.dart';
import '../../core/colors/app_color.dart';

class MoviesWidget extends StatefulWidget {
  final String? Function(int index)? imageBuilder;
  final int? moviesLength;

  const MoviesWidget({super.key, this.moviesLength, this.imageBuilder});

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
            itemCount: widget.moviesLength,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 8,
              childAspectRatio: 1 / 1.5,
            ),

            itemBuilder: (context, index) {
              return Stack(
                children: [
                  CachedNetworkImage(imageUrl: widget.imageBuilder!(index)!),

                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 10.11,
                    ),
                    padding: EdgeInsetsDirectional.all(6),
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColor.black.withAlpha(171),
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    width: 62,
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('7.7', style: context.fonts.titleSmall),
                        Icon(Icons.star, color: AppColor.goldenYellow),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}