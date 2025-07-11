import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundcolor,
    required this.textcolor,
    required this.onPressed,
  });

  final String text;
  final int backgroundcolor;
  final int textcolor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Color(textcolor),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(backgroundcolor),
        minimumSize: const Size(300, 50),
      ),
    );
  }
}
