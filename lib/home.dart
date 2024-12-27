import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
    required this.user_level,
    required this.user_xp,
  });
  final String title;
  final int user_level;
  final int user_xp;

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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "NanoScience",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text("Level 999")
                  ],
                ),
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
                  FilledButton.tonal(
                      style: buttonStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              globalStyles.colors.primary),
                          foregroundColor: WidgetStateProperty.all(
                              globalStyles.colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/play');
                      },
                      child: Text("Play")),
                  FilledButton.tonal(
                      style: buttonStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              globalStyles.colors.accent),
                          foregroundColor: WidgetStateProperty.all(
                              globalStyles.colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/leaderboard');
                      },
                      child: const Text("Leaderboard")),
                  FilledButton.tonal(
                      style: buttonStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              globalStyles.colors.secondary),
                          foregroundColor: WidgetStateProperty.all(
                              globalStyles.colors.black)),
                      onPressed: () {},
                      child: const Text("Shop")),
                  FilledButton(
                      style: buttonStyle,
                      onPressed: null,
                      child: const Text("Account")),
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
