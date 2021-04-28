import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String finalResult = "0";
  String equation = "";

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
                padding: const EdgeInsets.fromLTRB(6, 10, 5, 0),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        equation,
                        style: TextStyle(fontSize: 21, color: Colors.black54),
                        maxLines: 25,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(finalResult,
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex:3,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        buttonTap: () {
                          setState(() {
                            equationResult();
                          });
                        },
                      );

                      // Clear button
                    } else if (index == 0) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        buttonTap: () {
                          setState(() {
                            equation = "";
                            finalResult = "0";
                          });
                        },
                      );

                      // Delete button
                    } else if (index == 1) {
                      return MyButtons(
                        buttonColor: Colors.red,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        buttonTap: () {
                          setState(() {
                            if (equation.length > 0) {
                              equation =
                                  equation.substring(0, equation.length - 1);
                            }
                          });
                        },
                      );

                      // equal button
                    } else if (index == 18) {
                      return MyButtons(
                        buttonText: buttons[index],
                        textColor: Colors.black,
                        buttonColor: Color(0xFFE9F0F4),
                        buttonTap: () {
                          setState(() {
                            plusMinus();
                          });
                        },
                      );

                      // percentage button
                    } else if (index == 2) {
                      return MyButtons(
                        buttonText: buttons[index],
                        textColor: Colors.black,
                        buttonColor: Color(0xFFE9F0F4),
                        buttonTap: () {
                          setState(() {
                            percent();
                          });
                        },
                      );

                      // divide button
                    }
                    return MyButtons(
                      buttonText: buttons[index],
                      buttonColor: isOperator(buttons[index])
                          ? Color(0xFFFF9500)
                          : Color(0xFFE9F0F4),
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                      buttonTap: () {
                        setState(() {
                          equation += buttons[index];
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String text) {
    if (text == "x" || text == "-" || text == "+" || text == "/") {
      return true;
    } else {
      return false;
    }
  }

  void equationResult() {
    String finalEquation = equation;
    finalEquation = finalEquation.replaceAll("x", "*");
    int lastOperatorIndex = lastOperator();
    if (finalEquation[finalEquation.length - 1] == "0" &&
        finalEquation[lastOperatorIndex] == "/") {
      finalResult = "Can't divide by Zero";
    } else {
      Parser p = Parser();
      Expression exp = p.parse(finalEquation);
      double result = exp.evaluate(EvaluationType.REAL, null);
      finalResult = result.toString();
    }
  }

  // plus and minus button
  void plusMinus() {
    int lastOperatorIndex;
    int number;

    List<String> op = ["+", "-", "x", "/"];
    if (equation.contains(RegExp(r'^-?\d[\d ]*$'))) {
      number = int.parse(equation);
      number = number * -1;
      equation = number.toString();
    } else {
      
      lastOperatorIndex = lastOperator();
      if (equation[lastOperatorIndex] == "-") {
        number = int.parse(equation.substring(lastOperatorIndex + 1, equation.length));
        // number = number * -1;
        equation = equation.replaceAll(
            equation.substring(lastOperatorIndex, equation.length),
            ("+" + number.toString()));
      } else if (equation[lastOperatorIndex] == "+") {
        number = int.parse(equation.substring(lastOperatorIndex + 1, equation.length));
        number = number * -1;
        equation =
            equation.replaceAll(equation.substring(lastOperatorIndex), number.toString());
      } else {
        number = int.parse(equation.substring(lastOperatorIndex + 1, equation.length));
        number = number * -1;
        equation = equation.substring(0, lastOperatorIndex + 1) + number.toString();
      }
    }
  }

  // percentage button
  void percent() {
    double num1;
    int lastOperatorIndex = lastOperator();
    num1 = double.parse(equation.substring(lastOperatorIndex + 1, equation.length));
    equation = equation.substring(0, lastOperatorIndex + 1) +
        equation.substring(lastOperatorIndex + 1, equation.length) +
        "%";
    num1 = num1 / 100;
    equation = equation.replaceAll(
        equation.substring(lastOperatorIndex + 1, equation.length), num1.toString());
  }

  int lastOperator() {
    int lastOperatorIndex;
    List op = ["+", "-", "x", "/"];
    for (int i = equation.length - 1; i >= 0; i--) {
      if (op.contains(equation[i])) {
        lastOperatorIndex = i;
        break;
      }
    }
    return lastOperatorIndex;
  }
}
