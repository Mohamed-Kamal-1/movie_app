part of 'onboarding_bloc.dart';


@immutable
sealed class OnboardingEvent {}

class OnNextSlide extends OnboardingEvent {}

class OnPreviousSlide extends OnboardingEvent {}

class OnResetSlides extends OnboardingEvent {}