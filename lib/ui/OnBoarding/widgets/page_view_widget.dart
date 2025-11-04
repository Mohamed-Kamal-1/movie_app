import 'package:flutter/material.dart';
import 'package:movie_app/ui/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/ui/OnBoarding/on_boarding_details.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key, required this.onBoarding});

  final OnBoardingDetails onBoarding;

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(widget.onBoarding.image),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.onBoarding.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              Text(
                widget.onBoarding.description,
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
                child: Text("Explore Now"),
              ),
              SizedBox(height: 33),
            ],
          ),
        ),
      ],
    );
  }
}
