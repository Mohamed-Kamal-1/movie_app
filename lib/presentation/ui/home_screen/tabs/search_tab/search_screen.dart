import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
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

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<SearchScreenViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSearchWidget(
          onSearch: (title) => viewModel.getMoviesListByTitle(title),
        ),
        body: BlocBuilder<SearchScreenViewModel, SearchScreenState>(
          bloc: viewModel,
          builder: (context, state) {
            switch (state.runtimeType) {
              case SearchInitialState:
              case SearchEmptyState:
                {
                  return Center(
                    child: Image.asset(AppImage.searchImage, fit: BoxFit.cover),
                  );
                }
              case SearchLoadingState:
                return const Center(child: CircularProgressIndicator());
              case SearchErrorState:
                {
                  final errorState = state as SearchErrorState;
                  return Center(
                    child: Text(
                      errorState.errorMessage!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
              case SearchSuccessState:
                {
                  final successState = state as SearchSuccessState;
                  if (state.moviesList != null &&
                      state.moviesList!.isNotEmpty) {
                    return MoviesWidget(
                      moviesLength: state.moviesList?.length ?? 0,
                      imageBuilder: (index) {
                        return state.moviesList![index].mediumCoverImage;
                      },
                    );
                  } else {
                    return Center(
                      child: Image.asset(
                        AppImage.searchImage,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
