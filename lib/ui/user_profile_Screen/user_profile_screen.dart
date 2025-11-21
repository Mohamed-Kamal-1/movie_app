import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/ui/user_profile_Screen/profile_tabs.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_header.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: AppColor.black,
                  pinned: false,
                  floating: false,
                  snap: false,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(background: ProfileHeader()),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(70),
                      child: Container(
                        color: AppColor.whiteGrey,
                        child: const TabBar(
                          // labelColor: AppColor.goldenYellow,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.list,size: 30,
                                  color: AppColor.goldenYellow),
                              child: Text("Watch List",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.white,
                                fontWeight: FontWeight.w400,
                              ),),
                            ),
                            Tab(
                              icon: Icon(Icons.folder,size: 30,
                                  color: AppColor.goldenYellow),
                              child: Text("History",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w400,
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },

            body: TabBarView(
              children: [
                const WatchListViewContainer(),
                Center(
                  child: Text("History Not Connected",
                    style: Theme.of(context).textTheme.titleMedium,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _TabBarDelegate({required this.child});

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}
