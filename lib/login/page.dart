import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: globalStyles.colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(globalStyles.border.radius.xl)),
                    boxShadow: globalStyles.boxShadow.xl2),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                width: 400.0,
                child: Column(children: []))));
  }
}
