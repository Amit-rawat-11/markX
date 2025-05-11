// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mark_x/theme/text_style.dart';

class InputTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  const InputTextfield({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,

        labelStyle: MXTextStyles.bodyBold,
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
