import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key, required this.user_id});
  final int user_id;

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
          title: const Text('AppBar Sample'),
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
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
