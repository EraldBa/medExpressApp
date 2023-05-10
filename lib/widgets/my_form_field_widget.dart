import 'package:flutter/material.dart';

abstract class MyFormFieldWidget extends StatelessWidget {
  final RegExp? _emailValidator;

  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool isEmail;
  final void Function(String)? onChanged;

  MyFormFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.isEmail = false,
    this.onChanged,
  }) : _emailValidator = isEmail
            ? RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            : null;

  String? validator(String? value) {
    if (value == null) {
      return 'Please enter a value';
    }

    if (obscureText && value.length < 10) {
      return 'Password is too short, must be at least 10 characters long.';
    }

    if (isEmail && !_emailValidator!.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }
}
