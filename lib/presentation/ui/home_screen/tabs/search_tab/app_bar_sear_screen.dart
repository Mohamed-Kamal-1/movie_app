import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/extensions/extension.dart';

class AppBarSearchWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String title)? onSearch;

  const AppBarSearchWidget({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: Container(
          alignment: Alignment.center,
          height: 55.72,
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            cursorColor: AppColor.yellow,
            onChanged: onSearch,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.2,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white70,
                size: 22,
              ),
              hintText: "Search",
              hintStyle: context.fonts.titleMedium?.copyWith(
                color: Colors.white54,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
