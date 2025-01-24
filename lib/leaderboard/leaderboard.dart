import "dart:collection";

import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:mathlympics/models.dart";

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

  Mode selectedMode = Mode.cal20;
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
                          onPressed: () {
                            _LeaderboardListDisplay.clearCache();
                            Navigator.popAndPushNamed(context, "/");
                          }),
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
                            selectedMode = Mode.ranked;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      _buildSidebarButton(
                        "Cal x20",
                        Icons.calculate,
                        () {
                          setState(() {
                            selectedMode = Mode.cal20;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      _buildSidebarButton(
                        "Cal x50",
                        Icons.calculate,
                        () {
                          setState(() {
                            selectedMode = Mode.cal50;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      _buildSidebarButton(
                        "Integral x10",
                        Icons.functions,
                        () {
                          setState(() {
                            selectedMode = Mode.integ10;
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
                              key: ValueKey(selectedMode),
                              title: titles[0],
                              userID: widget.userId,
                              mode: selectedMode,
                            ),
                            LeaderboardListDisplay(
                              key: ValueKey(selectedMode),
                              title: titles[1],
                              userID: widget.userId,
                              mode: selectedMode,
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
    Mode buttonType;
    switch (text) {
      case "Ranked":
        buttonType = Mode.ranked;
      case "Cal x20":
        buttonType = Mode.cal20;
      case "Cal x50":
        buttonType = Mode.cal50;
      case "Integral x10":
        buttonType = Mode.integ10;
      default:
        buttonType = Mode.ranked;
    }

    Color buttonColor = selectedMode == buttonType
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
    required this.title,
    required this.mode,
  });
  final String userID;
  final String title;
  final Mode mode;

  @override
  State<LeaderboardListDisplay> createState() => _LeaderboardListDisplay();
}

class _LeaderboardListDisplay extends State<LeaderboardListDisplay> {
  static final Map<String, _LeaderboardCacheData> _leaderboardCache = {};

  Iterable<LeaderboardModel> leaderboardScore = [];
  late LeaderboardModel? userScore;
  Map<String, String> _usernameMap = {};
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  static void clearCache() {
    _leaderboardCache.clear();
  }

  Future<void> _loadUserData() async {
    String modeName = widget.mode.name;

    if (_leaderboardCache.containsKey(modeName)) {
      final cachedData = _leaderboardCache[modeName]!;
      setState(() {
        leaderboardScore = cachedData.leaderboardScore;
        _usernameMap = cachedData.usernameMap;
        userScore = cachedData.userScore;
      });
      return;
    }
    final userData = (await supabase
        .from("leaderboard")
        .select()
        .eq("mode", modeName)
        .eq("uid", widget.userID));
    final leaderboardData = (await supabase
        .from("leaderboard")
        .select()
        .eq("mode", modeName)
        .order("score", ascending: true)
        .limit(25));

    final userIds = leaderboardData.map((e) => e["uid"]).toSet().toList();
    List<dynamic> usernames = [];
    if (userIds.isNotEmpty) {
      usernames = await supabase.from("users").select("id, displayName");
    }
    final usernameMap = {
      for (var user in usernames)
        user["id"] as String: user["displayName"] as String
    };
    final processedLeaderboardScore =
        leaderboardData.map((hashMap) => LeaderboardModel.fromJson(hashMap));

    // Cache the fetched data
    _leaderboardCache[modeName] = _LeaderboardCacheData(
      leaderboardScore: processedLeaderboardScore,
      usernameMap: usernameMap,
      userScore: userData
          .map((hashMap) => LeaderboardModel.fromJson(hashMap))
          .firstOrNull,
    );

    setState(() {
      userScore = userData
          .map((hashMap) => LeaderboardModel.fromJson(hashMap))
          .firstOrNull;
      leaderboardScore = processedLeaderboardScore;
      //leaderboardData.map((hashMap) => LeaderboardModel.fromJson(hashMap));
      _usernameMap = usernameMap;
    });
  }

  Future<String?> getTopUserName(String userId) async {
    final response = await supabase
        .from("users")
        .select("displayName")
        .eq("id", userId)
        .single();

    return response["displayName"] as String;
  }

  //TODO ADD CACHING -> at least for swithicng tabs
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      itemCount: leaderboardScore.length > 25 ? 25 : leaderboardScore.length,
      itemBuilder: (BuildContext context, index) {
        final int displayIndex = index + 1;
        final topUserData = leaderboardScore.elementAt(index);
        print("${topUserData.uid} \n\n\n\n\n\n\n\n\n");
        final topUserName = _usernameMap[topUserData.uid] ?? "Unknown User";

        final Color containerColor;
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
                        topUserName,
                        style: globalStyles.font.normal,
                      ),
                      Text(
                        "Time: ${topUserData.score}",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 83, 103, 113)),
                      ),
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

class _LeaderboardCacheData {
  final Iterable<LeaderboardModel> leaderboardScore;
  final Map<String, String> usernameMap;
  final LeaderboardModel? userScore;

  _LeaderboardCacheData({
    required this.leaderboardScore,
    required this.usernameMap,
    required this.userScore,
  });
}
