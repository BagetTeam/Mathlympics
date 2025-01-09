import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:flutter_svg/flutter_svg.dart";

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    //final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: globalStyles.colors.white)
    final Color oddItemColor = globalStyles.colors.primary;
    final Color evenItemColor = globalStyles.colors.secondary;
    const int tabsCount = 2;
    const List<String> titles = <String>["Friends", "Global"];
    final BoxDecoration tabStyle =
        BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
      BoxShadow(
          color: const Color.fromARGB(84, 0, 0, 0),
          offset: Offset(1, 3),
          blurRadius: 5,
          blurStyle: BlurStyle.inner)
    ]);

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: globalStyles.colors.primary,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () async {
                      await Navigator.popAndPushNamed(context, "/");
                    },
                  ),
                  Text(
                    "Back",
                    style: globalStyles.font.header,
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Math Battle Leaderboard",
                    style: globalStyles.font.title2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: 48), // TODO change this T-T
            ],
          ),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            dividerColor: globalStyles.colors.primary,
            labelColor: globalStyles.colors.white,
            labelStyle: globalStyles.font.header
                .copyWith(color: globalStyles.colors.white),
            unselectedLabelColor: globalStyles.colors.black,
            unselectedLabelStyle: globalStyles.font.header,
            indicatorColor: globalStyles.colors.secondary,
            indicator: BoxDecoration(
              color: globalStyles.colors.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 22.0,
                    ),
                    SizedBox(
                        width:
                            8), // Adds some space between the icon and the text
                    Text(
                      titles[0],
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/trophy_icon.svg",
                      width: 22.0,
                      height: 22.0,
                    ),
                    SizedBox(
                        width:
                            10), // Adds some space between the icon and the text
                    Text(
                      titles[1],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 228, 228, 228),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, index) {
                final int displayIndex = index + 1;

                Color containerColor;
                String? medalIcon;
                if (displayIndex == 1) {
                  containerColor = Colors.amber;
                  medalIcon = "assets/icons/gold_medal.svg";
                } else if (displayIndex == 2) {
                  containerColor = const Color.fromARGB(255, 167, 167, 167);
                  medalIcon = "assets/icons/silver_medal.svg";
                } else if (displayIndex == 3) {
                  containerColor = const Color.fromARGB(255, 178, 113, 90);
                  medalIcon = "assets/icons/bronze_medal.svg";
                } else {
                  containerColor = globalStyles.colors.white;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(
                          8), // Optional: add rounded corners
                    ),
                    padding: EdgeInsets.all(
                        16), // Optional: add padding inside the container
                    child: Row(
                      children: [
                        if (medalIcon !=
                            null) // Add the medal icon for the top three
                          SvgPicture.asset(
                            medalIcon,
                            width: 24,
                            height: 24,
                          )
                        else // Display the rank number for the rest
                          Text(
                            "$displayIndex",
                            style: globalStyles.font.button,
                          ),
                        SizedBox(
                            width:
                                4), // Add some space between icon/number and text
                        Expanded(
                          child: Text(
                            titles[0],
                            style: globalStyles.font.button,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, index) {
                final int displayIndex = index + 1;
                Color containerColor;
                String? medalIcon;
                if (displayIndex == 1) {
                  containerColor = Colors.amber;
                  medalIcon = "assets/icons/gold_medal.svg";
                } else if (displayIndex == 2) {
                  containerColor = const Color.fromARGB(255, 167, 167, 167);
                  medalIcon = "assets/icons/silver_medal.svg";
                } else if (displayIndex == 3) {
                  containerColor = const Color.fromARGB(255, 178, 113, 90);
                  medalIcon = "assets/icons/bronze_medal.svg";
                } else {
                  containerColor = globalStyles.colors.white;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(
                          8), // Optional: add rounded corners
                    ),
                    padding: EdgeInsets.all(
                        16), // Optional: add padding inside the container
                    child: Row(
                      children: [
                        if (medalIcon !=
                            null) // Add the medal icon for the top three
                          SvgPicture.asset(
                            medalIcon,
                            width: 24,
                            height: 24,
                          )
                        else // Display the rank number for the rest
                          Text(
                            "$displayIndex",
                            style: globalStyles.font.button,
                          ),
                        SizedBox(
                            width:
                                4), // Add some space between icon/number and text
                        Expanded(
                          child: Text(
                            titles[1],
                            style: globalStyles.font.button,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
