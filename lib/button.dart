import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String buttonText;
  final buttonColor;
  final textColor;
  final buttonTap;

  MyButtons(
      {this.buttonText, this.textColor, this.buttonColor, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(20),
          child: Container(
            
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}
