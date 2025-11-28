// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/domain/model/movie_model.dart';
//
// import '../../../../core/images/app_image.dart';
// import '../cubit/home_screen_view_model.dart';
//
// class MoviesListWidget extends StatefulWidget {
//   final HomeScreenViewModel viewModel;
//   final List<MovieModel> movies;
//   final PageController pageController;
//
//   const MoviesListWidget({
//     super.key,
//     required this.viewModel,
//     required this.movies,
//     required this.pageController,
//   });
//
//   @override
//   State<MoviesListWidget> createState() => _MoviesListWidgetState();
// }
//
// class _MoviesListWidgetState extends State<MoviesListWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: PageView.builder(
//             controller: widget.pageController,
//             itemCount: widget.movies.length ?? 0,
//             itemBuilder: (context, index) {
//               return AnimatedBuilder(
//                 animation: widget.pageController,
//                 builder: (context, child) {
//                   double value = 1;
//                   if (widget.pageController.position.haveDimensions) {
//                     value = (widget.pageController.page! - index).abs();
//                     value = (1 - value * 0.3).clamp(0.8, 1.0);
//                   }
//                   return Transform.scale(scale: value, child: child);
//                 },
//                 child: Container(
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CachedNetworkImage(
//                     fit: BoxFit.fill,
//                     imageUrl: widget.movies[index].mediumCoverImage ?? "",
//                     placeholder: (context, url) =>
//                         Center(child: CircularProgressIndicator()),
//
//                     errorWidget: (context, url, error) =>
//                         Icon(Icons.broken_image, size: 40, color: Colors.grey),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
