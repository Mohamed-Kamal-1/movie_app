import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:provider/provider.dart';

import '../../provider/watch_now_section_view_model.dart';

class WatchNowSection extends StatefulWidget {
  final List<String> images;

  const WatchNowSection({super.key, required this.images});

  @override
  State<WatchNowSection> createState() => _WatchNowSectionState();
}

class _WatchNowSectionState extends State<WatchNowSection> {
  late WatchNowSectionViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.getMoviesListByGenres('Comedy');
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WatchNowSectionViewModel>(
        builder: (context, viewModel, child) {
          var screenState = viewModel.state;
          switch (screenState.state) {
            case ScreenState.initial:
            case ScreenState.Loading:
              return Center(child: CircularProgressIndicator());

            case ScreenState.Success:
              return ListView.separated(
                physics: PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          viewModel.state.movies![index].mediumCoverImage!,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemCount: widget.images.length,
              );
            case ScreenState.Error:
              return Center(
                child: Text(
                  screenState.errorMessage ?? "Something went wrong",
                  style: context.fonts.bodyMedium,
                ),
              );
          }
        },
      ),
    );
  }
}
