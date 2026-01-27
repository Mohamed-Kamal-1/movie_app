import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/brows_tab/browse_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/profile_tab/profile.dart';

import '../../../../../core/di/di.dart';
import '../../cubit/home_screen_view_model.dart';
import '../search_tab/search_screen.dart';
import 'bottom_navigation_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late List<Widget> tabs;
  @override
  void initState() {
    super.initState();
    tabs = [
      const HomeScreen(),
      const SearchScreen(),
      const BrowseScreen(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HomeScreenViewModel>(),
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        buildWhen: (previous, current) =>
            current is MoveToAnotherTabState && previous != current,
        builder: (context, state) {
          final viewModel = context.read<HomeScreenViewModel>();
          final currentIndex = state is MoveToAnotherTabState
              ? (state.index ?? 0)
              : 0;
          return Scaffold(
            bottomNavigationBar: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(37),
              ),
              margin: EdgeInsets.only(bottom: 16, right: 8, left: 8),
              child: AppBottomNavigationSection(
                onSelectedIndex: (index) {
                  if(currentIndex == index)return;
                  viewModel.moveAnotherTab(index);
                },
              ),
            ),
            body: tabs[currentIndex],
          );
        },
      ),
    );
  }
}
