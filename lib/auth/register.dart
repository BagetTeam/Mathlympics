import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "package:mathlympics/models.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(child: SizedBox(width: 350, child: RegisterForm())));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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

        final res =
            await supabase.auth.signUp(email: email, password: password);

        final user = res.user;

        if (user == null) {
          setState(() {
            _errorMsg = "Oops, something went wrong";
          });
          return;
        }

        final Iterable<UserModel> data =
            (await supabase.from("users").select().eq("id", user.id))
                .map((hashMap) => UserModel.from(hashMap));

        if (data.isNotEmpty) {
          setState(() {
            _errorMsg = "Account already exists";
          });
          return;
        }

        await supabase.from("users").insert({});

        if (context.mounted) {
          await Navigator.pushNamed(context, "/confirm-email");
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
                    if (val == null || val.length < 6) {
                      msg = "At least 6 characters";
                    }
                    return msg;
                  },
                  decoration: InputDecoration(
                      errorText: _errorMsg,
                      labelText: "Password",
                      border: UnderlineInputBorder())),
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
                  child: Text("Register",
                      style: TextStyle(
                        fontSize: globalStyles.font.lg.size,
                      )))),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Already have an account? "),
            GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, "/login");
                },
                child: Text("Login",
                    style: TextStyle(
                      color: Colors.lightBlue,
                    )))
          ])
        ]));
  }
}

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                spacing: 10.0,
                mainAxisSize: MainAxisSize.min,
                children: [
          Text("Welcome!",
              style: TextStyle(fontSize: globalStyles.font.xl3.size)),
          Text(
              "Your account has been created, remember your email in case you forget your password!"),
          GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, "/");
              },
              child: Text("Back to home",
                  style: TextStyle(color: Colors.lightBlue)))
        ])));
  }
}
