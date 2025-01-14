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
            child: SizedBox(
          width: 350,
          child: LoginForm(),
        )));
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

  String? _errorMsg;

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

          if (res.session == null || res.user == null) {
            setState(() {
              _errorMsg = "Oops, something went wrong";
            });
          } else {
            if (context.mounted) {
              await Navigator.pushNamed(context, "/");
            }
          }
        } on Exception {
          setState(() {
            _errorMsg = "Email or password incorrect";
          });
        }
      };

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, spacing: 20.0, children: [
          Column(
            spacing: 10.0,
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
                      errorText: _errorMsg,
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
                      errorText: _errorMsg,
                      labelText: "Password",
                      border: UnderlineInputBorder())),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, "/forgot-pass");
                      },
                      child: Text("I forgor",
                          style: TextStyle(color: Colors.lightBlue))))
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: handleSubmit(context),
                  style: FilledButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: Text("Login",
                      style: TextStyle(
                        fontSize: globalStyles.font.lg.size,
                      )))),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Don't have an account? "),
            GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, "/register");
                },
                child: Text("Register",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    )))
          ])
        ]));
  }
}
