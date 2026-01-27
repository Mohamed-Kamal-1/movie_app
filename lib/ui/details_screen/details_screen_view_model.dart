import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/domain/use_case/favourite_use_case.dart';
import 'package:movie_app/domain/use_case/movie_details_use_case.dart';
import 'package:movie_app/domain/use_case/movie_suggestion_use_case.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';

import '../../api/model/movie_details/movie_details_response_dto.dart';
import '../../api/model/movie_suggestion/movie_suggestion_response_dto.dart';

@injectable
class DetailsScreenViewModel extends Cubit<DetailsScreenState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  final MovieSuggestionUseCase movieSuggestionUseCase;
  final FavouriteUseCase favouriteUseCase;

  DetailsScreenViewModel(
    this.movieDetailsUseCase,
    this.movieSuggestionUseCase,
    this.favouriteUseCase,
  ) : super(DetailsScreenInitialState());

  Future<void> getMovieDetailsAndSuggestions(int movieId) async {
    // Start loading movie details first
    emit(MovieDetailsLoadingState());
    
    // Load movie details
    getMovieDetails(movieId);
    
    // Load suggestions separately (don't wait for details)
    getMovieSuggestions(movieId);
  }

  MovieSuggestionResponseDto? _cachedSuggestions;
  MovieDetailsResponseDto? _cachedDetails;

  Future<void> getMovieDetails(int movieId) async {
    try {
      final movieDetailsResponse = await movieDetailsUseCase.getMovieDetails(movieId);

      if (movieDetailsResponse.status == "ok") {
        _cachedDetails = movieDetailsResponse;
        
        // Check if suggestions are already loaded
        if (_cachedSuggestions != null) {
          emit(DetailsAndSuggestionsSuccessState(
            movieDetailsResponse: movieDetailsResponse,
            movieSuggestionResponse: _cachedSuggestions!,
          ));
        } else {
          emit(MovieDetailsSuccessState(
            movieDetailsResponse: movieDetailsResponse,
          ));
        }
      } else {
        emit(MovieDetailsErrorState(
          message: "Failed to load movie details",
        ));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(message: e.toString()));
    }
  }

  Future<void> getMovieSuggestions(int movieId) async {
    try {
      // Get current state to preserve movie details if already loaded
      final currentState = state;
      MovieDetailsResponseDto? movieDetailsResponse;
      
      if (currentState is MovieDetailsSuccessState) {
        movieDetailsResponse = currentState.movieDetailsResponse;
        _cachedDetails = movieDetailsResponse;
      } else if (currentState is DetailsAndSuggestionsSuccessState) {
        movieDetailsResponse = currentState.movieDetailsResponse;
        _cachedDetails = movieDetailsResponse;
      } else if (currentState is SuggestionsLoadingState) {
        movieDetailsResponse = currentState.movieDetailsResponse;
        _cachedDetails = movieDetailsResponse;
      }

      // Emit loading state with existing movie details if available
      if (movieDetailsResponse != null) {
        emit(SuggestionsLoadingState(movieDetailsResponse: movieDetailsResponse));
      }

      final movieSuggestionResponse = await movieSuggestionUseCase.getMovieSuggestion(movieId);

      if (movieSuggestionResponse.status == "ok") {
        _cachedSuggestions = movieSuggestionResponse;
        
        // If we have movie details, emit combined success state
        if (_cachedDetails != null) {
          emit(DetailsAndSuggestionsSuccessState(
            movieDetailsResponse: _cachedDetails!,
            movieSuggestionResponse: movieSuggestionResponse,
          ));
        }
      }
    } catch (e) {

      print('Error loading suggestions: $e');
    }
  }

  Future<void> checkIsFavourite(String movieId) async {
    try {
      // Check if user is logged in before making the API call
      final token = AuthSharedPreferences.getToken();
      if (token == null || token.isEmpty) {
        return;
      }

      final result = await favouriteUseCase.isFavourite(movieId);
      if (result != null) {
        emit(IsFavouriteSuccessState(isFavouriteModel: result));
      }
      // If result is null, silently fail - don't emit error state
      // This prevents the error state from replacing the success state
    } catch (e) {
      // Silently fail - don't emit error state to avoid replacing the main success state
      // The favorite check is a secondary feature that shouldn't block the UI
      print('Error checking favourite status: $e');
    }
  }

  Future<void> addMovieToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) async {
    try {
      final result = await favouriteUseCase.addToFavourite(
        addFavouriteData: addFavouriteData,
      );
      if (result != null && result.statusCode == null) {
        emit(AddToFavouriteSuccessState(message: result.message ?? "Added to favourites"));
      } else {
        emit(AddToFavouriteErrorState(
          message: result?.message ?? "Failed to add to favourites",
        ));
      }
    } catch (e) {
      emit(AddToFavouriteErrorState(message: e.toString()));
    }
  }

  Future<void> removeFromFavourite(String movieId) async {
    try {
      final result = await favouriteUseCase.removeFromFavourite(movieId);
      if (result != null && result.statusCode == null) {
        emit(RemoveFromFavouriteSuccessState(
          message: result.message ?? "Removed from favourites",
        ));
      } else {
        emit(RemoveFromFavouriteErrorState(
          message: result?.message ?? "Failed to remove from favourites",
        ));
      }
    } catch (e) {
      emit(RemoveFromFavouriteErrorState(message: e.toString()));
    }
  }
}

