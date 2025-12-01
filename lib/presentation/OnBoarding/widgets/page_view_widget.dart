import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import '../basic_on_boarding.dart';
import '../on_boarding_details.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key, required this.onBoarding});

  final OnBoardingDetails onBoarding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(onBoarding.image),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                onBoarding.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              Text(
                onBoarding.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withAlpha(153),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return BasicOnBoarding();
                      },
                    ),
                  );
                },
                child: Text("Explore Now" , style:TextStyle(color: AppColor.black),),
              ),
              SizedBox(height: 33),
            ],
          ),
        ),
      ],
    );
  }
}
