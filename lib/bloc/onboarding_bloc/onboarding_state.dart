part of 'onboarding_bloc.dart';

@immutable
class OnboardingState {
  final int index;

  const OnboardingState({required this.index});
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial() : super(index: 0);
}