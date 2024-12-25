import 'package:flutter/material.dart';
import 'package:mathlympics/leaderboard.dart';
import 'global_styles.dart';
import 'home.dart';
import 'logos.dart';

void main() {
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(
              title: 'Mathlympics',
              user_level: 0,
              user_xp: 0,
              logo: Logos.appLogo(),
            ),
        '/leaderboard': (context) => const Leaderboard(user_id: 0)
      },
    );
  }
}
