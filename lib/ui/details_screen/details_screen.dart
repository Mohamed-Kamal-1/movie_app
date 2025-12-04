import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:movie_app/ui/details_screen/widgets/details_shimmer_widget.dart';

import 'custom_widget/details_content.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'DetailsScreen';

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final movieId = args?.toString() ?? '';

    final viewModel = getIt.get<DetailsScreenViewModel>();

    if (movieId.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Movie ID not provided', style: AppStyles.regular16White),
        ),
      );
    }

    return Scaffold(
      body: BlocProvider<DetailsScreenViewModel>.value(
        value: viewModel..getMovieDetailsAndSuggestions(movieId),
        child: BlocBuilder<DetailsScreenViewModel, DetailsScreenState>(
          buildWhen: (previous, current) {
            // Only rebuild when state type changes or when we get new data
            return previous.runtimeType != current.runtimeType ||
                current is MovieDetailsSuccessState ||
                current is DetailsAndSuggestionsSuccessState ||
                current is SuggestionsLoadingState;
          },
          builder: (context, state) {
            // Initial loading - show full shimmer
            if (state is MovieDetailsLoadingState) {
              return const DetailsShimmerWidget();
            }

            // Movie details loaded but suggestions still loading
            if (state is MovieDetailsSuccessState) {
              final movieDetails = state.movieDetailsResponse.data?.movie;

              if (movieDetails == null) {
                return Center(
                  child: Text(
                    'Movie details not found',
                    style: AppStyles.regular16White,
                  ),
                );
              }

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: const [],
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            // Both loaded successfully
            if (state is DetailsAndSuggestionsSuccessState) {
              final movieDetails = state.movieDetailsResponse.data?.movie;
              final suggestions =
                  state.movieSuggestionResponse.data?.movies ?? [];

              if (movieDetails == null) {
                return Center(
                  child: Text(
                    'Movie details not found',
                    style: AppStyles.regular16White,
                  ),
                );
              }

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: false,
              );
            }

            // Suggestions loading (with movie details already shown)
            if (state is SuggestionsLoadingState) {
              final movieDetails = state.movieDetailsResponse?.data?.movie;
              final suggestions = const <dynamic>[];

              if (movieDetails == null) {
                return const DetailsShimmerWidget();
              }

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            // Error states
            if (state is MovieDetailsErrorState ||
                state is DetailsScreenErrorState) {
              final message = state is MovieDetailsErrorState
                  ? state.message
                  : (state as DetailsScreenErrorState).message;
              return Center(
                child: Text(message, style: AppStyles.regular16White),
              );
            }

            // Default/Unknown state
            return const DetailsShimmerWidget();
          },
        ),
      ),
    );
  }
}
