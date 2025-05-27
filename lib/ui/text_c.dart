import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const MyText({super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber.shade900
          )
        ),
        hintText: hintText,
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}