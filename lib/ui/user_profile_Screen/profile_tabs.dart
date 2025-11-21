import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: const TabBar(
              labelColor: Colors.white,
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

          Expanded(
            child: TabBarView(
              children: [
                WatchListViewContainer(),

                Center(
                  child: Text(
                    "History Content Here",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WatchListViewContainer extends StatelessWidget {
  const WatchListViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(5, (i) => "item $i");

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: dummyList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Container(margin: const EdgeInsets.all(8), color: Colors.red);
      },
    );
  }
}
