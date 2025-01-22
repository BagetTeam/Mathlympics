import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:mathlympics/models.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:mathlympics/auth/state.dart";

class PlayNormal extends StatelessWidget {
  const PlayNormal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = UserState.of(context).user;
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
                      await Navigator.pushNamed(context, "/normal/cal20",
                          arguments: {
                            "userID": user?.id,
                            "mode": Mode.cal20,
                          });
                    },
                    child: Text("Calculation x20")),
                FilledButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, "/normal/integrals",
                          arguments: {
                            "userID": user?.id,
                            "mode": Mode.integ10,
                          });
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
