import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/styles/app_styles.dart';

class GenresWrap extends StatelessWidget {
  final List<String> genres;
  final double width;
  final double height;

  const GenresWrap({
    super.key,
    required this.genres,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: width * 0.03,
      runSpacing: height * 0.015,
      children: genres.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
            vertical: height * 0.01,
          ),
          decoration: BoxDecoration(
            color: AppColor.gray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            genre,
            style: AppStyles.regular16White,
          ),
        );
      }).toList(),
    );
  }
}
