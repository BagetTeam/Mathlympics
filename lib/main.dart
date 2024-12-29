import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathlympics/leaderboard.dart';
import 'package:mathlympics/login/page.dart';
import 'package:mathlympics/normal_game_screen.dart';
import 'package:mathlympics/play_screen.dart';
import 'global_styles.dart';
import 'home.dart';
import 'logos.dart';
import 'firebase_options.dart';
import 'game_over_screen.dart';

/// Sets up the preferred device orientations and system UI mode.
Future<void> setUp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathlympics',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: globalStyles.colors.primary),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(
              title: 'Mathlympics',
              logo: Logos.appLogo(),
              userLevel: 0,
              userXp: 0,
            ),
        '/leaderboard': (context) => const Leaderboard(userId: 0),
        '/play': (context) => const PlayScreen(),
        '/play/normal': (context) => const PlayNormal(),
        '/play/ranked': (context) => const PlayRanked(),
        '/play/normal/cal20': (context) => const NormalGameScreen(),
        '/play/normal/integrals': (context) =>
            const NormalGameScreen(isIntegral: true),
        '/login': (context) => const LoginPage(),
        '/game-over': (context) => const GameOverScreen(),
        '/signin': (context) => const LoginPage(), // TODO: replace by signin
        '/account': (context) => const LoginPage(), // TODO: replace by account
        '/shop': (context) => const LoginPage(), // TODO: replace by shop
      },
    );
  }
}
