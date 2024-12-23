import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(500, 35)),
      textStyle:
          WidgetStateProperty.all(TextStyle(fontSize: globalStyles.font.size)),
    );
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: globalStyles.colors.white,
      //   title: Center(
      //     child: Text(widget.title),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  widget.title,
                  style: globalStyles.font.title,
                ),
              ),
            ),
            FilledButton.tonal(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(globalStyles.colors.primary),
                    foregroundColor:
                        WidgetStateProperty.all(globalStyles.colors.black)),
                onPressed: incrementCounter,
                child: Text("Play $counter")),
            FilledButton.tonal(
                style: buttonStyle.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(globalStyles.colors.accent),
                    foregroundColor:
                        WidgetStateProperty.all(globalStyles.colors.black)),
                onPressed: () {},
                child: const Text("Leaderboard")),
            FilledButton.tonal(
                style: buttonStyle,
                // style: buttonStyle.copyWith(
                //     backgroundColor:
                //         WidgetStateProperty.all(globalStyles.colors.accent),
                //     foregroundColor:
                //         WidgetStateProperty.all(globalStyles.colors.black)),
                onPressed: null,
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
