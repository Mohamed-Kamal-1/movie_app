import 'package:flutter/material.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../../../../core/colors/app_color.dart';

class RatingWidget extends StatelessWidget {
  final String rate;

  const RatingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 13.11),
      padding: const EdgeInsetsDirectional.all(6),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.black.withAlpha(171),
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
     constraints: BoxConstraints(
       maxWidth: 70,
       maxHeight: 40
     ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(rate, style: context.fonts.titleSmall),
          const Icon(Icons.star, color: AppColor.goldenYellow),
        ],
      ),
    );
  }
}
