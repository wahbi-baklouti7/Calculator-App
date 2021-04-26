import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String buttonText;
  final buttonColor;
  final textColor;

  MyButtons({this.buttonText, this.textColor, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: buttonColor,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: textColor, fontSize: 21, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
