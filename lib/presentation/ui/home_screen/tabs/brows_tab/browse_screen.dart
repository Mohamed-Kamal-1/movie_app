import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/colors/app_color.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../cubit/browse_cubit.dart';
import '../../widgets/browse_shimmer_widget.dart';
import 'movie_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BrowseCubit>()..loadMovies(),
      child: Scaffold(
        backgroundColor: const Color(0xff121312),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                /// STATE builder
                Expanded(
                  child: BlocBuilder<BrowseCubit, BrowseState>(
                    builder: (context, state) {
                      if (state is BrowseLoading) {
                        return const BrowseShimmerWidget();
                      }

                      if (state is BrowseError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state is BrowseLoaded) {
                        return Column(
                          children: [
                            /// GENRE CHIPS
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.genres.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (_, index) {
                                  final genre = state.genres[index];
                                  final isSelected = genre == state.selectedGenre;

                                  return GestureDetector(
                                    onTap: () {
                                      context.read<BrowseCubit>().filterByGenre(genre);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColor.goldenYellow
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColor.goldenYellow,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          genre,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.black
                                                : AppColor.goldenYellow,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// MOVIES GRID
                            Expanded(
                              child: GridView.builder(
                                itemCount: state.movies.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: .62,
                                    ),
                                itemBuilder: (_, index) {
                                  final movie = state.movies[index];
                                  return MovieCard(
                                    movie: movie,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.DetailsScreen.name,
                                        arguments: movie.id,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
