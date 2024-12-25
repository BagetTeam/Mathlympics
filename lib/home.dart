import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';
import 'package:mathlympics/leaderboard.dart';

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
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: logo,
            ),
            FilledButton.tonal(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(globalStyles.colors.primary),
                    foregroundColor:
                        WidgetStateProperty.all(globalStyles.colors.black)),
                onPressed: () {},
                child: Text("Play")),
            FilledButton.tonal(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(globalStyles.colors.accent),
                    foregroundColor:
                        WidgetStateProperty.all(globalStyles.colors.black)),
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
                child: const Text("Leaderboard")),
            FilledButton.tonal(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(globalStyles.colors.secondary),
                    foregroundColor:
                        WidgetStateProperty.all(globalStyles.colors.black)),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
