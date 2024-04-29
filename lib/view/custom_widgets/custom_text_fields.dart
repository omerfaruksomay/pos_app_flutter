import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isObscure,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final bool? isObscure;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      controller: controller,
      cursorColor: Color.fromRGBO(46, 99, 110, 1),
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(color: Color.fromRGBO(46, 99, 110, 1)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color.fromRGBO(46, 99, 110, 1),
          ),
        ),
      ),
    );
  }
}
