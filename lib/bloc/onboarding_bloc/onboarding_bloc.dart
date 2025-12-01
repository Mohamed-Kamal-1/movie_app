

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final int totalSlides;

  OnboardingBloc({required this.totalSlides})
      : super(OnboardingInitial()) {
    on<OnNextSlide>((event, emit) {
      if (state.index < totalSlides - 1) {
        emit(OnboardingState(index: state.index + 1));
      }
    });

    on<OnPreviousSlide>((event, emit) {
      if (state.index > 0) {
        emit(OnboardingState(index: state.index - 1));
      }
    });

    on<OnResetSlides>((event, emit) {
      emit(OnboardingState(index: 0));
    });
  }
}
