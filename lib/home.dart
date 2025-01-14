import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:mathlympics/auth/state.dart";
import "package:mathlympics/global_styles.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.title,
    this.logo = const SizedBox.shrink(),
  });
  final String title;
  final Widget logo;

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    timeDilation = 2.0;
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat(reverse: true);
  }

  // @override
  // void didUpdateWidget(Home oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _controller.duration = const Duration(seconds: 15);
  // }

  @override
  void dispose() {
    _controller.dispose();
    timeDilation = 1.0;
    super.dispose();
  }

  Widget _buildAnimatedShape(
    Widget child,
    double Function(double) xCalculation,
    double Function(double) yCalculation,
  ) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        return Positioned(
          left: xCalculation(_controller.value) * screenWidth,
          top: yCalculation(_controller.value) * screenHeight,
          child: Opacity(opacity: 0.2, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalStyles.colors.white,
      body: Stack(
        children: [
          _buildAnimatedShape(
            Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 500,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            (value) => 1 - value * 1.4,
            (value) => 0.8 - value * 0.6,
          ),
          _buildAnimatedShape(
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 241, 84),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
            (value) => 0.2 + value * 0.5,
            (value) => -0.3 + value * 0.2,
          ),
          _buildAnimatedShape(
            Transform.rotate(
              angle: 0.3,
              child: Image.asset(
                "assets/images/integral_symb.png",
                width: 150,
                height: 150,
              ),
            ),
            (value) => 0 + value * 0.65,
            (value) => 0.5 + value * 0.1,
          ),
          _buildAnimatedShape(
            Transform.rotate(
              angle: -0.1,
              child: Image.asset(
                "assets/images/multiply_symb.png",
                width: 120,
                height: 120,
              ),
            ),
            (value) => 1 - value * 1.2,
            (value) => 0 + value * 0.8,
          ),
          Row(
            children: <Widget>[
              Expanded(flex: 1, child: ProfileSection()),
              Expanded(
                flex: 2,
                child: ButtonSection(
                  label: widget.title,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(224, 171, 227, 255),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: constraints.maxWidth * 0.25,
                child: Image.asset(
                  "assets/images/main_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "NanoScience",
                style: globalStyles.font.header,
              ),
              Text(
                "Level 99999",
                style: globalStyles.font.normal,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.15,
              ),
              Text(
                "Total Wins: 999999999",
                style: globalStyles.font.normal,
              ),
              Text(
                "Global Rank: #1",
                style: globalStyles.font.normal,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.15,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Settings")),
            ],
          );
        }),
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    User? user = UserState.of(context).user;

    VoidCallback handleClick(String path) => () async {
          if (path == "/leaderboard" || path == "/ranked") {
            if (user == null) {
              path = "/login";
            } else if (user.emailConfirmedAt == null) {
              path = "/confirm-email";
            }
          }

          await Navigator.pushNamed(context, path);
        };

    final ButtonStyle buttonStyle = ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size(500, 35)),
        textStyle: WidgetStateProperty.all(globalStyles.font.button),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent));

    final BoxDecoration buttonBoxStyle =
        BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
      BoxShadow(
          color: const Color.fromARGB(84, 0, 0, 0),
          offset: Offset(1, 3),
          blurRadius: 5,
          blurStyle: BlurStyle.inner)
    ]);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Center(
              child: Text(
                label,
                style: globalStyles.font.title,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: buttonBoxStyle.copyWith(
              gradient: LinearGradient(
                colors: [
                  globalStyles.colors.primary,
                  globalStyles.colors.secondary,
                  const Color.fromARGB(255, 28, 115, 255),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FilledButton.tonal(
              style: buttonStyle,
              onPressed: handleClick("/normal"),
              child: Text("Quick Play", style: globalStyles.font.button),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: buttonBoxStyle.copyWith(
              gradient: LinearGradient(
                colors: [
                  globalStyles.colors.green,
                  globalStyles.colors.green2,
                  globalStyles.colors.green3,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FilledButton.tonal(
              style: buttonStyle,
              onPressed: handleClick("/ranked"),
              child: Text("Ranked", style: globalStyles.font.button),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: buttonBoxStyle.copyWith(
              gradient: LinearGradient(
                colors: [
                  globalStyles.colors.accent2,
                  globalStyles.colors.accent3,
                  globalStyles.colors.accent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: FilledButton.tonal(
              style: buttonStyle,
              onPressed: handleClick("/leaderboard"),
              child: Text(
                "Leaderboard",
                style: globalStyles.font.button,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: buttonBoxStyle.copyWith(
              gradient: LinearGradient(
                colors: [
                  globalStyles.colors.red3,
                  globalStyles.colors.red2,
                  globalStyles.colors.red,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: FilledButton.tonal(
              style: buttonStyle,
              // TODO: add nav when shop is made
              onPressed: () {},
              child: Text(
                "Shop",
                style: globalStyles.font.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
