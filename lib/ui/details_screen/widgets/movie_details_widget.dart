import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/movie_details/movie_details_dto.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:movie_app/ui/details_screen/widgets/web_view_screen.dart';

class MovieDetailsWidget extends StatefulWidget {
  final MovieDetailsDto movieDetails;
  final DetailsScreenViewModel viewModel;

  const MovieDetailsWidget({
    super.key,
    required this.movieDetails,
    required this.viewModel,
  });

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.checkIsFavourite(widget.movieDetails.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocListener<DetailsScreenViewModel, DetailsScreenState>(
      bloc: widget.viewModel,
      listener: (context, state) {
        if (state is IsFavouriteSuccessState) {
          setState(() {
            isFavourite = state.isFavouriteModel.data ?? false;
          });
        } else if (state is AddToFavouriteSuccessState) {
          widget.viewModel.checkIsFavourite(widget.movieDetails.id.toString());
        } else if (state is RemoveFromFavouriteSuccessState) {
          widget.viewModel.checkIsFavourite(widget.movieDetails.id.toString());
        }
      },
      child: BlocBuilder<DetailsScreenViewModel, DetailsScreenState>(
        bloc: widget.viewModel,
        buildWhen: (previous, current) =>
            current is IsFavouriteSuccessState ||
            current is AddToFavouriteSuccessState ||
            current is RemoveFromFavouriteSuccessState,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CachedNetworkImage(
                      height: height * 0.7,
                      imageUrl: widget.movieDetails.largeCoverImage ?? "",
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color: AppColor.yellow),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error, color: Colors.red, size: 35),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.7,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(230, 0, 0, 0),
                            Color.fromARGB(150, 0, 0, 0),
                            Color.fromARGB(100, 0, 0, 0),
                            Color.fromARGB(230, 12, 13, 12),
                          ],
                          stops: [0.0, 0.3, 0.6, 1.0],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            top: height * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppImage.backIcon,
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (!isFavourite) {
                                    final addFavouriteData =
                                        AddToFavouriteDataModel(
                                      imageURL: widget.movieDetails.largeCoverImage,
                                      movieId:
                                          widget.movieDetails.id.toString(),
                                      name: widget.movieDetails.title,
                                      rating: widget.movieDetails.rating,
                                      year: widget.movieDetails.year?.toString(),
                                    );
                                    widget.viewModel.addMovieToFavourite(
                                      addFavouriteData: addFavouriteData,
                                    );
                                  } else {
                                    widget.viewModel.removeFromFavourite(
                                      widget.movieDetails.id.toString(),
                                    );
                                  }
                                },
                                child: Image.asset(
                                  AppImage.bookmarkIcon,
                                  width: 28,
                                  height: 28,
                                  color: isFavourite
                                      ? AppColor.yellow
                                      : AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.21),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewScreen(
                                    newsUrl: widget.movieDetails.url ?? "",
                                  ),
                                ),
                              );
                            },
                            child: Image.asset(
                              AppImage.playIcon,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.17),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.movieDetails.title ?? "",
                              style: AppStyles.bold24White,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.movieDetails.year.toString(),
                              style: AppStyles.bold20White,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.01,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            newsUrl: widget.movieDetails.url ?? "",
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(

                      backgroundColor: AppColor.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Watch',
                      style: AppStyles.bold20White,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _CustomContainerWidget(
                          icon: Icons.favorite,
                          number:
                              widget.movieDetails.likeCount?.toString() ?? "0",
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: _CustomContainerWidget(
                          icon: Icons.access_time,
                          number: widget.movieDetails.runtime?.toString() ?? "0",
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: _CustomContainerWidget(
                          icon: Icons.star,
                          number: widget.movieDetails.rating
                                  ?.toStringAsFixed(1) ??
                              "0",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomContainerWidget extends StatelessWidget {
  final IconData icon;
  final String number;

  const _CustomContainerWidget({
    required this.icon,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.gray,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColor.yellow, size: 20),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              number,
              style: AppStyles.bold24White,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
