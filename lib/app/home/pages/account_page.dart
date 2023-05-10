import 'package:flutter/material.dart';
import 'package:med_express/app/home/widgets/account_page_button.dart';
import 'package:med_express/app/home/widgets/account_page_field.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with AdaptiveScreenMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _username;
  String? _email;
  String? _pasword;

  void _clearFields() {
    _formKey.currentState!.reset();

    setState(() {
      _username = _email = _pasword = null;
    });
  }

  void _saveChange() {
    if (!_formKey.currentState!.validate()) return;

    show
        .warningPopUp(
      context,
      message: 'Are you sure you want to save changes?',
    )
        .then((accepted) {
      if (accepted) {
        User.current.updateUser(
          username: _username,
          email: _email,
          password: _pasword,
        );
        show.successSnackBar(context, message: 'Changes saved!');
      } else {
        show.warningSnackBar(context, message: 'Changes not saved.');
      }
    });

    _clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          const Text(
            'Edit Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(
            Icons.person,
            size: 150.0,
          ),
          const SizedBox(height: 40.0),
          Container(
            padding: isBigScreen(context)
                ? const EdgeInsets.symmetric(horizontal: 200.0)
                : null,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AccountPageField(
                    labelText: 'Username',
                    hintText: User.current.username,
                    onChanged: (text) => _username = text,
                  ),
                  AccountPageField(
                    labelText: 'Email',
                    hintText: User.current.email,
                    isEmail: true,
                    onChanged: (text) => _email = text,
                  ),
                  AccountPageField(
                    labelText: 'Password',
                    hintText: '••••••••••',
                    obscureText: true,
                    onChanged: (text) => _pasword = text,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 260.0),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        AccountPageButton(
                            text: 'Cancel', onPressed: _clearFields),
                        AccountPageButton(text: 'Save', onPressed: _saveChange),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
