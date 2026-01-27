import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/extention/error_extention.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/search_tab/cubit/search_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/search_tab/cubit/search_screen_view_model.dart';
import 'package:movie_app/presentation/ui/movies_widget.dart';

import 'app_bar_sear_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchScreenViewModel viewModel;
  bool isEmpty = false;
  int imageIndex = 0;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<SearchScreenViewModel>();
  }

  void _onSearchChanged(String title) {
    if (title.isEmpty) {
      _debounce?.cancel();

      isEmpty = true;

      return;
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 820), () {
      if (title.isNotEmpty) {
        viewModel.getMoviesListByTitle(title);
        isEmpty = false;
      }
    },);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSearchWidget(
          onSearch: (title) {
            _onSearchChanged(title);
            if(title.isEmpty){
              isEmpty = true;
            }
          },
        ),
        body: BlocBuilder<SearchScreenViewModel, SearchScreenState>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is SearchInitialState || state is SearchEmptyState) {
              return Center(
                  child: Image.asset(AppImage.searchImage, fit: BoxFit.cover));
            }

            if (state is SearchLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.amber));
            }

            if (state is SearchErrorState) {
              return Center(
                child: Text(
                  context.getErrorMessage(state.errorMessage),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (state is SearchSuccessState) {
              final movies = state.moviesList ?? [];

              if (movies.isNotEmpty && state.moviesList != null) {
                return MoviesWidget(movies: movies);
              } else {
                return Center(child: Image.asset(
                    AppImage.searchImage, fit: BoxFit.cover));
              }
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
