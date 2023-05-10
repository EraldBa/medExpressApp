import 'package:flutter/material.dart';
import 'package:med_express/widgets/my_form_field_widget.dart';

class AccountPageField extends MyFormFieldWidget {
  AccountPageField({
    super.key,
    super.onChanged,
    super.isEmail,
    super.obscureText,
    required super.labelText,
    required super.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
