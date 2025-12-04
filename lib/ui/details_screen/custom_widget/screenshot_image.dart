import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';

class ScreenshotImage extends StatelessWidget {
  final String imageUrl;
  const ScreenshotImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height * 0.2,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: AppColor.yellow),
        ),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error, color: Colors.red, size: 38),
      ),
    );
  }
}
