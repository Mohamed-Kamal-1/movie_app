
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../cubit/watch_now_state.dart';
import '../../cubit/watch_now_view_model.dart';

class WatchNowSection extends StatefulWidget {
  final String randomGenre;

  const WatchNowSection({super.key, required this.randomGenre});

  @override
  State<WatchNowSection> createState() => _WatchNowSectionState();
}

class _WatchNowSectionState extends State<WatchNowSection> {
  late WatchNowViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<WatchNowViewModel>();
    viewModel.getMoviesListByGenres(widget.randomGenre);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchNowViewModel, WatchNowState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is WatchNowLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WatchNowError) {
          return Center(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (state is WatchNowSuccess) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            itemCount: state.moviesList?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.DetailsScreen.name,
                      arguments: state.moviesList![index].id,
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: state.moviesList![index].mediumCoverImage ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 20),
          );
        }

        return const SizedBox();
      },
    );
  }
}
