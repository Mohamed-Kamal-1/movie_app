import 'package:flutter/material.dart';
import 'package:movie_app/presentation/OnBoarding/widgets/page_view_widget.dart';

import 'on_boarding_details.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                var onBoarding = OnBoardingDetails.onBoardingList[index];
                return PageViewWidget(onBoarding: onBoarding);
              },
            ),
          ),
        ],
      ),
    );
  }
}
