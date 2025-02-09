import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";

class GameOverScreen extends StatelessWidget {
  final double finalTime;

  const GameOverScreen({super.key, required this.finalTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [globalStyles.colors.primary, globalStyles.colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: globalStyles.colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: globalStyles.colors.secondary,
                width: 3.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Game Over!",
                  style: globalStyles.font.title
                      .copyWith(color: globalStyles.colors.secondary),
                ),
                const SizedBox(height: 20),
                Text(
                  "You got everything right. Anouk are the best",
                  style: globalStyles.font.header
                      .copyWith(color: globalStyles.colors.secondary),
                ),
                const SizedBox(height: 20),
                Text(
                  "Final Time: $finalTime seconds",
                  style: globalStyles.font.normal
                      .copyWith(color: globalStyles.colors.secondary),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(context, "/normal");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: globalStyles.colors.secondary,
                  ),
                  child: Text("Back to Home",
                      style: globalStyles.font.normal.copyWith(
                          color: const Color.fromARGB(235, 255, 255, 255))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
