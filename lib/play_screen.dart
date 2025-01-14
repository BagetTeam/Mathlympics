import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";

class PlayScreen extends StatelessWidget {
  const PlayScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, "/normal");
                },
                child: Text("Normal")),
            FilledButton(onPressed: () {}, child: Text("Ranked")),
          ],
        ),
      ),
    );
  }
}

class PlayNormal extends StatelessWidget {
  const PlayNormal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () async {
                    await Navigator.popAndPushNamed(context, "/");
                  },
                ),
                Text(
                  "Quick Play",
                  style: globalStyles.font.header,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, "/normal/cal20");
                    },
                    child: Text("Calculation x20")),
                FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/normal/integrals");
                    },
                    child: Text("Integrals")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayRanked extends StatelessWidget {
  const PlayRanked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}
