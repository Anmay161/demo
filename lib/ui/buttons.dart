
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Function()? ontap;
  final String data;
  const Buttons({
    super.key,
    required this.ontap,
    required this.data
  });
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ontap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.amber.shade900),
      ),
      child: Text(
        data,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}