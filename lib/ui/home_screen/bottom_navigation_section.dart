import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/extensions/extension.dart';

class AppBottomNavigationSection extends StatefulWidget {
  const AppBottomNavigationSection({super.key});

  @override
  State<AppBottomNavigationSection> createState() => _AppBottomNavigationSectionState();
}

class _AppBottomNavigationSectionState extends State<AppBottomNavigationSection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        backgroundColor:context.bottomNavBarTheme.backgroundColor,
        elevation: 0,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {

          });
          selectedIndex = value;
        },
        currentIndex: selectedIndex,

        items: [
          BottomNavigationBarItem(

            icon: Icon(Icons.warehouse_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: '',
          ),
        ]

    );
  }
}
