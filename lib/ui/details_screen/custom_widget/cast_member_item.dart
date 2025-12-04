import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/styles/app_styles.dart';

class CastMemberItem extends StatelessWidget {
  final dynamic castMember;
  final double width;
  final double height;

  const CastMemberItem({
    super.key,
    this.castMember,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.006),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.gray,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: castMember.urlSmallImage ?? '',
              width: width * 0.15,
              height: height * 0.07,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColor.yellow,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${castMember.name ?? "N/A"}',
                  style: AppStyles.regular20White,
                ),
                Text(
                  'Character: ${castMember.characterName ?? "N/A"}',
                  style: AppStyles.regular20White,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
