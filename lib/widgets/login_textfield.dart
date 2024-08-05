/*
This is custom Textfield for LoginScreen
 */


import 'package:flutter/material.dart';

class LoginTextfieldMaterial extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final String? Function(String?)? validator;
  final bool obscureText;

  const LoginTextfieldMaterial(
      {super.key,
      this.hintText,
      this.labelText,
      this.icon,
      this.controller,
      this.keyboardtype,
      this.validator,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
        )
      ),
    );
  }
}
