import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_bloc/onboarding_bloc.dart';
import '../../core/routes/app_routes.dart';
import 'on_boarding_details.dart';

class BasicOnBoarding extends StatelessWidget {
  const BasicOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OnBoardingDetails> mySlides = OnBoardingDetails.onBoardingList
        .sublist(1);

    return BlocProvider(
      create: (_) => OnboardingBloc(totalSlides: mySlides.length),
      child: _OnBoardingView(mySlides),
    );
  }
}

class _OnBoardingView extends StatelessWidget {
  final List<OnBoardingDetails> mySlides;
  final PageController _pageController = PageController();

  _OnBoardingView(this.mySlides);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final index = state.index;

          return Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.loose,
            children: [
              BlocListener<OnboardingBloc, OnboardingState>(
                listener: (context, state) {
                  _pageController.animateToPage(
                    state.index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mySlides.length,
                  itemBuilder: (context, index) {
                    return Image.asset(mySlides[index].image, fit: BoxFit.fill);
                  },
                ),
              ),

              IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
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
                      const SizedBox(height: 32),
                      Text(
                        mySlides[index].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),

                      mySlides[index].description.isNotEmpty
                          ? Text(
                              mySlides[index].description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          : const SizedBox.shrink(),

                      const SizedBox(height: 24),

                      // NEXT / FINISH BUTTON
                      ElevatedButton(
                        onPressed: () {
                          if (index == mySlides.length - 1) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.LoginScreen.name,
                            );
                          } else {
                            context.read<OnboardingBloc>().add(OnNextSlide());
                          }
                        },
                        child: Text(
                          index != (mySlides.length - 1) ? "Next" : "Finish",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(fontSize: 20),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // BACK BUTTON
                      index == 0
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                context.read<OnboardingBloc>().add(
                                  OnPreviousSlide(),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.yellow),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      "Back",
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
