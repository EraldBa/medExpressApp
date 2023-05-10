import 'package:flutter/material.dart';

import 'package:med_express/app/app.dart';
import 'package:med_express/app/enter/widgets/enter_form.dart';
import 'package:med_express/app/enter/widgets/enter_form_field.dart';
import 'package:med_express/app/home/pages/user_page.dart';
import 'package:med_express/app/home/widgets/loading_screen.dart';
import 'package:med_express/appearance/const_colors.dart' as const_colors;
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _formLogIn(BuildContext context) {
    showDialog(context: context, builder: (_) => const LoadingScreen());

    if (!_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      return;
    }

    User.logIn(
      username: _username,
      password: _password,
    ).then((errorOccured) {
      if (errorOccured) {
        show.errorSnackBar(context, message: 'Wrong credentials, try again!');
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, UserPage.route);
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
          colors: const_colors.logInBG,
        )),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back\nto ${App.name}!',
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                EnterFormField(
                  hintText: 'Username',
                  icon: Icons.person,
                  onChanged: (text) => _username = text,
                ),
                const SizedBox(height: 20.0),
                EnterFormField(
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock,
                  onChanged: (text) => _password = text,
                ),
                const SizedBox(height: 40.0),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.7),
                  onPressed: () => _formLogIn(context),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text('Login'),
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
