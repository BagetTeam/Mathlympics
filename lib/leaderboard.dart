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
          automaticallyImplyLeading: false,
          title: Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () async {
                    await Navigator.popAndPushNamed(context, "/");
                  },
                ),
                Text(
                  "Leaderboard",
                  style: globalStyles.font.header,
                ),
              ],
            ),
          ),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people),
                    SizedBox(
                        width:
                            8), // Adds some space between the icon and the text
                    Text(
                      titles[0],
                      style: globalStyles.font.header,
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bolt_outlined),
                    SizedBox(
                        width:
                            8), // Adds some space between the icon and the text
                    Text(
                      titles[1],
                      style: globalStyles.font.header,
                    ),
                  ],
                ),
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
