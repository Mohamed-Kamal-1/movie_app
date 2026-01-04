import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/icons/app_icon.dart';
import 'package:movie_app/extensions/extension.dart';

typedef OnSelectedIndex = void Function(int index);

class AppBottomNavigationSection extends StatefulWidget {
  final OnSelectedIndex? onSelectedIndex;

  const AppBottomNavigationSection({super.key, this.onSelectedIndex});

  @override
  State<AppBottomNavigationSection> createState() =>
      _AppBottomNavigationSectionState();
}

class _AppBottomNavigationSectionState
    extends State<AppBottomNavigationSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        useLegacyColorScheme: false,
        backgroundColor: context.bottomNavBarTheme.backgroundColor,
        elevation: 0,
        selectedItemColor: AppColor.yellow,
        unselectedItemColor: AppColor.white,

        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
            widget.onSelectedIndex?.call(value);
          });
        },
        currentIndex: selectedIndex,

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.ic_home, height: 30),
            activeIcon: SvgPicture.asset(
              AppIcon.ic_home,
              height: 25,

              colorFilter: ColorFilter.mode(AppColor.yellow, BlendMode.srcIn),
            ),

            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              alignment: Alignment.center,
              width: 24,
              height: 24,
              child: SvgPicture.asset(AppIcon.ic_search),
            ),
            activeIcon: SvgPicture.asset(
              AppIcon.ic_search,
              colorFilter: ColorFilter.mode(AppColor.yellow, BlendMode.srcIn),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.ic_compass),
            activeIcon: SvgPicture.asset(
              AppIcon.ic_compass,
              colorFilter: ColorFilter.mode(AppColor.yellow, BlendMode.srcIn),
            ),

            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcon.ic_profile),
            activeIcon: SvgPicture.asset(
              AppIcon.ic_profile,
              colorFilter: ColorFilter.mode(AppColor.yellow, BlendMode.srcIn),
            ),

            label: '',
          ),
        ],
      ),
    );
  }


}
