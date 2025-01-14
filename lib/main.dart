import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mathlympics/auth/state.dart";
import "package:mathlympics/leaderboard.dart";
import "package:mathlympics/auth/login.dart";
import "package:mathlympics/auth/register.dart";
import "package:mathlympics/normal_game_screen.dart";
import "package:mathlympics/play_screen.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "global_styles.dart";
import "home.dart";
import "logos.dart";
import "game_over_screen.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

/// Sets up the preferred device orientations and system UI mode.
Future<void> setUp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
      url: dotenv.env["URL"]!, anonKey: dotenv.env["ANONKEY"]!);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await SystemChrome.setSystemUIChangeCallback(
      (systemOverlaysAreVisible) async {
    if (systemOverlaysAreVisible) {
      Future.delayed(const Duration(seconds: 2), () async {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      });
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  StreamSubscription<AuthState>? listener;

  @override
  void initState() {
    super.initState();

    final stateListener =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      // final AuthResponse res =
      //    await Supabase.instance.client.auth.refreshSession();
      final Session? session = data.session;

      final newUser = switch (event) {
        AuthChangeEvent.signedIn ||
        AuthChangeEvent.initialSession ||
        AuthChangeEvent.tokenRefreshed ||
        AuthChangeEvent.userUpdated =>
          session?.user,
        _ => null,
      };
      setState(() {
        user = newUser;
      });
    });

    setState(() {
      listener = stateListener;
    });
  }

  @override
  void dispose() async {
    await listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserState(
        user: user,
        child: MaterialApp(
          title: "Mathlympics",
          theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: globalStyles.colors.primary),
              useMaterial3: true,
              fontFamily: "Acme"),
          initialRoute: "/",
          routes: {
            "/": (context) => Home(
                  title: "Mathlympics",
                  logo: Logos.appLogo(),
                ),
            "/leaderboard": (context) => const Leaderboard(userId: 0),
            "/play": (context) => const PlayScreen(),
            "/normal": (context) => const PlayNormal(),
            "/ranked": (context) => const PlayRanked(),
            "/normal/cal20": (context) => const NormalGameScreen(),
            "/normal/integrals": (context) =>
                const NormalGameScreen(isIntegral: true),
            "/login": (context) => const LoginPage(),
            "/register": (context) => const RegisterPage(),
            "/confirm-email": (context) => const ConfirmEmail(),
            "/forgot-pass": (context) =>
                const RegisterPage(), // TODO: forgot page
            "/account": (context) =>
                const LoginPage(), // TODO: replace by account
            "/shop": (context) => const LoginPage(), // TODO: replace by shop
          },
          onGenerateRoute: (settings) {
            if (settings.name == "/game-over") {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) {
                  return GameOverScreen(finalTime: args["finalTime"]);
                },
              );
            }
            return null;
          },
        ));
  }
}

/*
*/
