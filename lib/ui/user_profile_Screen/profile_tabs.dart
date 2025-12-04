import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_view_model.dart';
import 'widgets/profile_shimmer_widget.dart';


class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: const TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                    color: AppColor.goldenYellow,
                  ),
                  child: Text(
                    "Watch List",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.folder,
                    size: 30,
                    color: AppColor.goldenYellow,
                  ),
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                WatchListViewContainer(),

                Center(
                  child: Text(
                    "History Content Here",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WatchListViewContainer extends StatelessWidget {
  const WatchListViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileScreenState>(
      builder: (context, state) {
        if (state is ProfileLoadingState || state is ProfileInitialState) {
          return const WatchListShimmer();
        }

        if (state is ProfileMoviesListLoaded) {
          if (state.list == null || state.list!.isEmpty) {
            return const Center(
              child: Text(
                "list is empty",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            physics: const BouncingScrollPhysics(),
            itemCount: state.list!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final movie = state.list![index];
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        movie.mediumCoverImage ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColor.gray,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${movie.rating.toString()} *",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ), //
                  ],
                ),
              );
            },
          );
        }

        return const Center(
          child: Text(
            "list is empty",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
