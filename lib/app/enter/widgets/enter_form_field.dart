import 'package:flutter/material.dart';
import 'package:med_express/appearance/themes.dart' as themes;
import 'package:med_express/widgets/my_form_field_widget.dart';

class EnterFormField extends MyFormFieldWidget {
  final IconData icon;

  EnterFormField({
    super.key,
    super.onChanged,
    super.obscureText,
    super.isEmail,
    required super.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: themes.standardInputDec(
        context,
        icon: icon,
        hintText: hintText,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
