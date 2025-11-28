import 'package:flutter/material.dart';
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

          // if (selectedIndex == 3) {
          //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          //     return UserProfileScreen();
          //   },));
          // }
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
