import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:mathlympics/backend/lib.dart";
import "package:mathlympics/global_styles.dart";

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.title,
    required this.user,
    this.logo = const SizedBox.shrink(),
  });
  final String title;
  final Widget logo;
  final User? user;

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

    VoidCallback handleClick(String path) => () async {
          await Navigator.pushNamed(context, path);
        };

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
                      onPressed: handleClick("play"),
                      child: Text("Play")),
                  FilledButton.tonal(
                      style: buttonStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              globalStyles.colors.accent),
                          foregroundColor: WidgetStateProperty.all(
                              globalStyles.colors.black)),
                      onPressed: handleClick("/leaderboard"),
                      child: const Text("Leaderboard")),
                  FilledButton.tonal(
                      style: buttonStyle.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                              globalStyles.colors.secondary),
                          foregroundColor: WidgetStateProperty.all(
                              globalStyles.colors.black)),
                      // FIX: uncomment this after adding the path
                      // onPressed: handleClick("/shop"),
                      onPressed: null,
                      child: const Text("Shop")),
                  FilledButton(
                      style: buttonStyle,
                      // FIX: uncomment this after adding the path
                      // onPressed: handleClick("/account"),
                      onPressed: null,
                      child: const Text("Account")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
