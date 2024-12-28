import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
    required this.userLevel,
    required this.userXp,
    this.logo = const SizedBox.shrink(),
  });
  final String title;
  final int userLevel;
  final int userXp;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(500, 35)),
        textStyle: WidgetStateProperty.all(globalStyles.font.button),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent));

    VoidCallback handleClick(String path) {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        path = "/login";
      }

      return () async {
        await Navigator.pushNamed(context, path);
      };
    }

    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              key: Key('value'),
              height: double.infinity,
              color: const Color.fromARGB(224, 171, 227, 255),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: constraints.maxWidth * 0.25,
                        child: Image.asset(
                          'assets/images/main_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "NanoScience",
                        style: globalStyles.font.header,
                      ),
                      Text(
                        "Level $userLevel",
                        style: globalStyles.font.normal,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.15,
                      ),
                      Text(
                        "Total Wins: 999999999",
                        style: globalStyles.font.normal,
                      ),
                      Text(
                        "Global Rank: #1",
                        style: globalStyles.font.normal,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.15,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Settings")),
                    ],
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        title,
                        style: globalStyles.font.title,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            globalStyles.colors.primary,
                            globalStyles.colors.secondary,
                            const Color.fromARGB(255, 28, 115, 255),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(125, 0, 0, 0),
                              offset: Offset(1, 4),
                              blurRadius: 5,
                              blurStyle: BlurStyle.inner)
                        ]),
                    child: FilledButton.tonal(
                      style: buttonStyle,
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/play');
                      },
                      child: Text("Play", style: globalStyles.font.button),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          globalStyles.colors.accent2,
                          globalStyles.colors.accent3,
                          globalStyles.colors.accent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FilledButton.tonal(
                      style: buttonStyle,
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/leaderboard');
                      },
                      child: Text(
                        "Leaderboard",
                        style: globalStyles.font.button,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          globalStyles.colors.red3,
                          globalStyles.colors.red2,
                          globalStyles.colors.red,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FilledButton.tonal(
                      style: buttonStyle,
                      //TODO add nav when shop is made
                      onPressed: () {},
                      child: Text(
                        "Shop",
                        style: globalStyles.font.button,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
