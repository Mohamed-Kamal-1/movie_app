import 'package:flutter/material.dart';

import '../../core/images/app_image.dart';

class AvatarSection extends StatefulWidget {
  const AvatarSection({super.key});

  @override
  State<AvatarSection> createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  final PageController avatarController = PageController(
    viewportFraction: 0.33,
  );

  final List<String> avatars = [
    AppImage.avatar_1,
    AppImage.avatar_2,
    AppImage.avatar_3,
    AppImage.avatar_4,
    AppImage.avatar_5,
    AppImage.avatar_6,
    AppImage.avatar_7,
    AppImage.avatar_8,
    AppImage.avatar_9,
  ];

  @override
  void dispose() {
    super.dispose();
    avatarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: avatarController,
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: avatarController,
            builder: (context, child) {
              double value = 1.0;
              if (avatarController.position.haveDimensions) {
                value = (avatarController.page! - index).abs();
                value = (1 - (value * 0.5)).clamp(0.5, 1.6);
              }
              return Center(
                child: Transform.scale(
                  scale: value,
                  child: GestureDetector(
                    onTap: () => avatarController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ),
                    child: CircleAvatar(
                      radius: 47 + (80 - 47) * value,
                      backgroundImage: AssetImage(avatars[index]),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
