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
                        Radius.circular(globalStyles.border.radius.base)),
                    boxShadow: globalStyles.boxShadow.base),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: 400.0,
                child: LoginForm())));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(spacing: 10.0, children: [
          TextFormField(
              decoration: InputDecoration(
                  labelText: "Email", border: UnderlineInputBorder())),
          TextFormField(
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder())),
        ]));
  }
}
