import 'package:flutter/material.dart';
import 'package:movie_app/core/images/app_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  double currentPage = 0.0;

  final List<String> images = [
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // الخلفية
                Positioned.fill(
                  child: Image.asset(AppImage.midImage, fit: BoxFit.fill),
                ),

                // التدرج
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.47, 1],
                      colors: [
                        const Color(0xFF121312).withValues(alpha: 0.45),
                        const Color(0xFF121312).withValues(alpha: 0.6),
                        const Color(0xFF121312).withValues(alpha: 1),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    Image.asset(AppImage.availableNow, width: double.infinity),

                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          double scale = (1.5 - (currentPage - index).abs())
                              .clamp(0.8, 1);
                          return AnimatedScale(
                            scale: scale,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          );
                          ;
                        },
                      ),
                    ),

                    Expanded(child: Image.asset(AppImage.watchNow, width: double.infinity)),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        // Text('A')
                      ],
                    ),
                  ],
                )
              ],
            ),

          ),

        ],
      ),
    );
  }
}

