import 'package:flutter/material.dart';

import 'package:movie_app/presentation/ui/movies_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: MoviesWidget(),
    );
  }
}
