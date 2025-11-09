import 'package:flutter/material.dart';

import '../../core/images/app_image.dart';

class AvailableNowSection extends StatefulWidget {
  List<String> images;

  AvailableNowSection({super.key, required this.images});

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  final PageController _pageController = PageController(viewportFraction: 0.65);

  double currentPage = 0.0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImage.availableNow, width: double.infinity),
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1;
                  if (_pageController.position.haveDimensions) {
                    value = (_pageController.page! - index).abs();
                    value = (1 - value * 0.3).clamp(0.8, 1.0);
                  }
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(widget.images[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Flexible(child: Image.asset(AppImage.watchNow, width: double.infinity)),
      ],
    );
  }
}
