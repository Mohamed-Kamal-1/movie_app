import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/routes/app_routes.dart';

import 'on_boarding_details.dart';

class BasicOnBoarding extends StatefulWidget {
  const BasicOnBoarding({super.key});

  @override
  State<BasicOnBoarding> createState() => _BasicOnBoardingState();
}

class _BasicOnBoardingState extends State<BasicOnBoarding> {
  final List<OnBoardingDetails> mySlides = OnBoardingDetails.onBoardingList
      .sublist(1);
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Image.asset(mySlides[_index].image, fit: BoxFit.fill);
            },
          ),

          IntrinsicHeight(
            child: Positioned(
              bottom: 0,
              // alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 32),
                    Text(
                      mySlides[_index].title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 16),
                    Text(
                      mySlides[_index].description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        _index == mySlides.length - 1
                            ? Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.LoginScreen.name,
                              )
                            : setState(() {
                                if (_index != mySlides.length - 1) {
                                  _index++;
                                }
                              });
                      },
                      child: Text(
                        _index != (mySlides.length - 1) ? "Next" : "Finish",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: AppColor.black , fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 16),

                    _index == 0
                        ? SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                if (_index != 0) {
                                  _index--;
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "Back",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.yellow),
                                    // style: T,
                                  ),
                                ),
                              ),
                            ),
                          ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
