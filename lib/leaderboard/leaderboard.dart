import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:mathlympics/models.dart";

enum NormalLevels {
  RANKED,
  CALCULATION20,
  INTEGRAL,
}

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key, required this.userId});
  final String userId;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    _tabController.addListener(() {
      if (!_pageController.position.isScrollingNotifier.value) {
        _pageController.animateToPage(
          _tabController.index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  NormalLevels Selected = NormalLevels.RANKED;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 2;
    const List<String> titles = <String>["FRIENDS", "GLOBAL"];
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: globalStyles.colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(130, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header section
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(8, 12, 16, 16),
                  //child:
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: globalStyles.colors.black, size: 24),
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, "/"),
                      ),
                      Expanded(
                        child: Text(
                          "Math Battle Leaderboard",
                          style: globalStyles.font.header.copyWith(
                            color: globalStyles.colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Left sidebar with buttons
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: globalStyles.colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(2, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSidebarButton(
                        "Ranked",
                        Icons.military_tech,
                        () {
                          setState(() {
                            Selected = NormalLevels.RANKED;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      _buildSidebarButton(
                        "Cal x20",
                        Icons.calculate,
                        () {
                          setState(() {
                            Selected = NormalLevels.CALCULATION20;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      _buildSidebarButton(
                        "Integral",
                        Icons.functions,
                        () {
                          setState(() {
                            Selected = NormalLevels.INTEGRAL;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // tab and leaderboard
                Expanded(
                  child: Column(
                    children: [
                      // Custom tabs
                      Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildCustomTab(
                                Icons.people_outline,
                                titles[0],
                                selectedTabIndex == 0,
                                screenWidth,
                                () async {
                                  setState(() => selectedTabIndex = 0);
                                  await _pageController.animateToPage(
                                    0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: _buildCustomTab(
                                Icons.emoji_events_outlined,
                                titles[1],
                                selectedTabIndex == 1,
                                screenWidth,
                                () async {
                                  setState(() => selectedTabIndex = 1);
                                  await _pageController.animateToPage(
                                    1,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Content area
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() => selectedTabIndex = index);
                          },
                          children: [
                            LeaderboardListDisplay(
                              title: titles[0],
                              userID: widget.userId,
                            ),
                            LeaderboardListDisplay(
                              title: titles[1],
                              userID: widget.userId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    NormalLevels buttonType;
    switch (text) {
      case "Ranked":
        buttonType = NormalLevels.RANKED;
      case "Cal x20":
        buttonType = NormalLevels.CALCULATION20;
      case "Integral":
        buttonType = NormalLevels.INTEGRAL;
      default:
        buttonType = NormalLevels.RANKED;
    }

    Color buttonColor = Selected == buttonType
        ? globalStyles.colors.secondary // Selected color
        : globalStyles.colors.primary;

    return Container(
      width: 100,
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fixedSize: Size.fromWidth(90),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 15),
            SizedBox(
              width: 3,
            ),
            Text(
              text,
              style: globalStyles.font.normal.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTab(
    IconData icon,
    String title,
    bool isSelected,
    double screenWidth,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        alignment:
            title == "FRIENDS" ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isSelected ? globalStyles.colors.secondary : Colors.transparent,
            borderRadius: BorderRadius.horizontal(
              left: title == "FRIENDS" ? Radius.circular(12) : Radius.zero,
              right: title == "GLOBAL" ? Radius.circular(12) : Radius.zero,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : globalStyles.colors.black,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: globalStyles.font.normal.copyWith(
                  color: isSelected ? Colors.white : globalStyles.colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardListDisplay extends StatefulWidget {
  const LeaderboardListDisplay({
    super.key,
    required this.userID,
    required this.title, //temp
  });
  final String userID;
  final String title; //TEMPORARY

  @override
  State<LeaderboardListDisplay> createState() => _LeaderboardListDisplay();
}

class _LeaderboardListDisplay extends State<LeaderboardListDisplay> {
  String? username;
  int? userLevel;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final global_data = (await supabase.from("top_scores").select())
        .map((hashMap) => UserModel.from(hashMap));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      itemCount: 25,
      itemBuilder: (BuildContext context, index) {
        final int displayIndex = index + 1;

        Color containerColor;
        String? medalIcon;
        if (displayIndex == 1) {
          containerColor = const Color.fromARGB(255, 255, 222, 122);
          medalIcon = "assets/icons/gold_medal.svg";
        } else if (displayIndex == 2) {
          containerColor = const Color.fromARGB(255, 209, 209, 209);
          medalIcon = "assets/icons/silver_medal.svg";
        } else if (displayIndex == 3) {
          containerColor = const Color.fromARGB(255, 215, 142, 115);
          medalIcon = "assets/icons/bronze_medal.svg";
        } else {
          containerColor = Colors.white;
        }

        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 4, top: 4),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                offset: Offset(4, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            children: [
              if (medalIcon != null) // Add the medal icon for the top three
                SvgPicture.asset(
                  medalIcon,
                  width: 20,
                  height: 20,
                )
              else // Display the rank number for the rest
                Container(
                  width: 20,
                  alignment: Alignment.center,
                  child: Text(
                    "$displayIndex",
                    style: globalStyles.font.header2,
                  ),
                ),
              SizedBox(width: 14),
              Expanded(
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/main_logo.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: globalStyles.font.normal,
                      ),
                      Text(
                        "Time: 0.00001s",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 83, 103, 113)),
                      )
                    ],
                  )
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
