import 'dart:isolate';

import 'package:flutter/material.dart';
import 'button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "12+5*18+9*78+2-100/5*105-5015+56-81*89/95";
  String finalResult = "1523";

  List<String> buttons = [
    "C",
    "DEL",
    "%",
    "+",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "x",
    "1",
    "2",
    "3",
    "/",
    "0",
    ".",
    "+/-",
    "="
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        equation,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        maxLines: 25,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(finalResult,
                          style: TextStyle(
                              fontSize: 55, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 19) {
                      return MyButtons(
                        buttonColor: Color(0xFF2EC973),
                        buttonText: buttons[19],
                        textColor: Colors.white,
                      );
                    } else if (index == 0) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                      );
                    }
                    return MyButtons(
                        buttonText: buttons[index],
                        buttonColor: isOperator(buttons[index])
                            ? Color(0xFFFF9500)
                            : Color(0xFFE9F0F4),
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool isOperator(String text) {
  if (text == "x" || text == "-" || text == "+" || text == "/") {
    return true;
  } else {
    return false;
  }
}
