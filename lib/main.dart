import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathlympics/leaderboard.dart';
import 'package:mathlympics/normal_game_screen.dart';
import 'package:mathlympics/play_screen.dart';
import 'global_styles.dart';
import 'home.dart';
import 'logos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
              user_level: 0,
              user_xp: 0,
              logo: Logos.appLogo(),
            ),
        '/leaderboard': (context) => const Leaderboard(user_id: 0),
        '/play': (context) => const PlayScreen(),
        '/play/normal': (context) => const PlayNormal(),
        '/play/ranked': (context) => const PlayRanked(),
        '/play/normal/cal20': (context) => const NormalGameScreen(),
      },
    );
  }
}
