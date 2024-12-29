import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    //final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: globalStyles.colors.white)
    final Color oddItemColor = globalStyles.colors.primary;
    final Color evenItemColor = globalStyles.colors.secondary;
    const int tabsCount = 2;
    const List<String> titles = <String>['Friends', 'Global'];

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, index) {
                final int displayIndex = index + 1;
                return ListTile(
                  tileColor: displayIndex.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $displayIndex'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, index) {
                final int displayIndex = index + 1;
                return ListTile(
                  tileColor: displayIndex.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $displayIndex'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
