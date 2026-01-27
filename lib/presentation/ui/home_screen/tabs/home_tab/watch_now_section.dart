import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/extention/error_extention.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';

import '../../cubit/watch_now_state.dart';
import '../../cubit/watch_now_view_model.dart';
import '../../widgets/home_shimmer_widget.dart';

class WatchNowSection extends StatelessWidget {
  final String randomGenre;

  const WatchNowSection({super.key, required this.randomGenre});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<WatchNowViewModel>()..getMoviesListByGenres(randomGenre),
      child: BlocBuilder<WatchNowViewModel, WatchNowState>(
        builder: (context, state) {
          if (state is WatchNowLoading) {
            return const WatchNowShimmer();
          }

          if (state is WatchNowError) {
            return Center(
              child: Text(
                context.getErrorMessage(state.errorMessage),
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (state is WatchNowSuccess) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              itemCount: state.moviesList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                movieId:
                                    state.moviesList[index].id?.toInt() ?? 0,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadiusGeometry.circular(20),
                          child: CachedNetworkImage(
                            memCacheHeight: 400,
                            memCacheWidth: 400,

                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                            imageUrl:
                                state.moviesList[index].mediumCoverImage ?? "",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    // RatingWidget(
                    //   rate: state.moviesList?[index].rating?.toStringAsFixed(1),
                    //
                    // ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
