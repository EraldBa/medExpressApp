import 'package:flutter/material.dart';
import 'package:med_express/app/app.dart';
import 'package:med_express/app/enter/pages/welcome_page.dart';
import 'package:med_express/app/enter/widgets/enter_form.dart';
import 'package:med_express/app/enter/widgets/enter_form_field.dart';
import 'package:med_express/appearance/const_colors.dart' as const_colors;
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _email = '';
  String _password = '';

  void _formSignUpThenLogIn(BuildContext context) {
    show.loadingScreen(context);

    if (!_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      return;
    }

    User.signUp(
      username: _username,
      email: _email,
      password: _password,
    ).then((errorOccured) {
      if (errorOccured) {
        show.errorSnackBar(
          context,
          message: 'Server error: username or email already exist',
        );
        Navigator.of(context).pop();
      } else {
        User.logIn(username: _username, password: _password)
            .then((errorOccured) {
          if (errorOccured) {
            show.errorSnackBar(
              context,
              message:
                  'Server error: user created but could not login, please try to log in later.',
            );
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            Navigator.popAndPushNamed(context, WelcomePage.route);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EnterForm(
      context,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const_colors.signUpBG,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome\nto ${App.name}!",
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                EnterFormField(
                  hintText: "Username",
                  icon: Icons.person,
                  onChanged: (text) => _username = text,
                ),
                const SizedBox(height: 20.0),
                EnterFormField(
                  hintText: "Email",
                  isEmail: true,
                  icon: Icons.email,
                  onChanged: (text) => _email = text,
                ),
                const SizedBox(height: 20.0),
                EnterFormField(
                  hintText: "Password",
                  obscureText: true,
                  icon: Icons.lock,
                  onChanged: (text) => _password = text,
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.7),
                  onPressed: () => _formSignUpThenLogIn(context),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("Sign-up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
