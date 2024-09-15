import 'package:flutter/material.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: false,
              tabAlignment: TabAlignment.fill,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
              dividerHeight: 2,
              dividerColor: Theme.of(context).splashColor,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Comments'),
                Tab(text: 'Likes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ...List.generate(
                    3,
                    (tabIndex) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, postIndex) {
                          return Container(
                            height: 100,
                            color: tabIndex.isOdd && postIndex.isOdd
                                ? Colors.blue.shade50
                                : tabIndex.isOdd && postIndex.isEven
                                    ? Colors.blue.shade100
                                    : tabIndex.isEven && postIndex.isOdd
                                        ? Colors.purple.shade50
                                        : Colors.purple.shade100,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
