import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Container(
                // decoration: BoxDecoration(
                //     color: globalStyles.colors.white,
                //     borderRadius: BorderRadius.all(
                //         Radius.circular(globalStyles.border.radius.base)),
                //     boxShadow: globalStyles.boxShadow.base),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: 350.0,
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  VoidCallback handleSubmit(BuildContext context) => () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }

        final email = _emailController.text;
        final password = _passwordController.text;

        try {
          final res = await Supabase.instance.client.auth
              .signInWithPassword(email: email, password: password);

          if (res.user == null || res.session == null) {
            setState(() {
              _isError = true;
            });
          } else if (context.mounted) {
            await Navigator.pushNamed(context, "/home");
          }
        } on Exception {
          setState(() {
            _isError = true;
          });
        }
      };

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(spacing: 30.0, children: [
          Text("Mathlympics", style: globalStyles.font.header),
          Column(
            spacing: 20.0,
            children: [
              TextFormField(
                  controller: _emailController,
                  validator: (val) {
                    String? msg;

                    if (val == null || val.isEmpty) {
                      msg = "Cannot be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(val)) {
                      msg = "Invalid email format";
                    }

                    return msg;
                  },
                  decoration: InputDecoration(
                      errorText: _isError ? "Wrong email" : null,
                      labelText: "Email",
                      border: UnderlineInputBorder())),
              TextFormField(
                  controller: _passwordController,
                  validator: (val) {
                    String? msg;
                    if (val == null || val.isEmpty) {
                      msg = "Cannot be empty";
                    }
                    return msg;
                  },
                  decoration: InputDecoration(
                      errorText: _isError ? "Wrong password" : null,
                      labelText: "Password",
                      border: UnderlineInputBorder())),
            ],
          ),
          FilledButton(
              onPressed: handleSubmit(context),
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.all(10.0))),
              child: Text("Login",
                  style: TextStyle(
                      fontFamily: "LuckiestGuy",
                      fontSize: globalStyles.font.lg.size)))
        ]));
  }
}
