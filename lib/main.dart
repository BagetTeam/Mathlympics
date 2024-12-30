import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mathlympics/leaderboard.dart";
import "package:mathlympics/login/page.dart";
import "package:mathlympics/normal_game_screen.dart";
import "package:mathlympics/play_screen.dart";
import "global_styles.dart";
import "home.dart";
import "logos.dart";
import "firebase_options.dart";
import "backend/lib.dart";

Future<void> setUp() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,
      overlays: []);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return MaterialApp(
      title: "Mathlympics",
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: globalStyles.colors.primary),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(
              title: "Mathlympics",
              logo: Logos.appLogo(),
              user: user,
            ),
        "/leaderboard": (context) => const Leaderboard(userId: 0),
        "/play": (context) => const PlayScreen(),
        "/play/normal": (context) => const PlayNormal(),
        "/play/ranked": (context) => const PlayRanked(),
        "/play/normal/cal20": (context) => const NormalGameScreen(),
        "/login": (context) => const LoginPage(),
        "/signin": (context) => const LoginPage(), // TODO: replace by signin
        "/account": (context) => const LoginPage(), // TODO: replace by account
        "/shop": (context) => const LoginPage(), // TODO: replace by shop
      },
    );
  }
}

/*
*/
