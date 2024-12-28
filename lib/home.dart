import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
    required this.user_level,
    required this.user_xp,
    this.logo = const SizedBox.shrink(),
  });
  final String title;
  final int user_level;
  final int user_xp;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(500, 35)),
      textStyle:
          WidgetStateProperty.all(TextStyle(fontSize: globalStyles.font.size)),
      padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
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
                        width: constraints.maxWidth * 0.25,
                        child: Image.asset(
                          'assets/images/main_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "NanoScience",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text("Level 999"),
                      SizedBox(
                        height: constraints.maxHeight * 0.15,
                      ),
                      Text("Total Wins: 999999999"),
                      Text("Global Rank: #1"),
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
                          globalStyles.colors.green,
                          const Color.fromARGB(255, 103, 245, 217),
                          globalStyles.colors.primary,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FilledButton.tonal(
                      style: buttonStyle.copyWith(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        foregroundColor:
                            WidgetStateProperty.all(globalStyles.colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/play');
                      },
                      child: Text("Play"),
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
                      style: buttonStyle.copyWith(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        foregroundColor:
                            WidgetStateProperty.all(globalStyles.colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/leaderboard');
                      },
                      child: const Text("Leaderboard"),
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
                      style: buttonStyle.copyWith(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        foregroundColor:
                            WidgetStateProperty.all(globalStyles.colors.black),
                      ),
                      onPressed: () {},
                      child: const Text("Shop"),
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
