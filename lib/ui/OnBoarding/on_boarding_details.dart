
import 'package:movie_app/core/images/app_image.dart';

class OnBoardingDetails{
  final String image;
  final String title;
  final String description;

  OnBoardingDetails({
    required this.image,
    required this.title,
     required this.description,
  });
  static List<OnBoardingDetails> onBoardingList = [
    OnBoardingDetails(image: AppImage.onBoarding_1,
        title: "Find Your Next Favorite Movie Here",
        description: "Get access to a huge library of movies to suit all tastes. You will surely like it."),
    OnBoardingDetails(image: AppImage.onBoarding_2,
        title: "Discover Movies",
        description: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease."),
    OnBoardingDetails(image: AppImage.onBoarding_3,
        title: "Explore All Genres",
        description: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day."),
    OnBoardingDetails(image: AppImage.onBoarding_4,
        title: "Create Watchlists",
        description: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres."),
    OnBoardingDetails(image: AppImage.onBoarding_5,
        title: "Rate, Review, and Learn",
        description: "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews."),
    OnBoardingDetails(image: AppImage.onBoarding_6,
        title: "Start Watching Now",
        description: ""),
  ];

}
