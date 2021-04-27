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
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                        maxLines: 25,
                      ),
                      SizedBox(
                        height: 15,
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
              flex: 3,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
    Parser p = Parser();
    Expression exp = p.parse(finalEquation);
    double result = exp.evaluate(EvaluationType.REAL, null);
    finalResult = result.toString();
  }

  void plusMinus() {
    int lastOp;
    List op = ["+", "-", "*", "/"];
    for (int i = equation.length - 1; i > 0; i--) {
      if (op.contains(equation[i])) {
        lastOp = i;
        break;
      }
    }
    if (equation[lastOp] == "-") {
      equation = equation.replaceAll("-", "+");
    } else if (equation[lastOp] == "+") {
      equation = equation.replaceAll("-", "+");
    } else if (equation[lastOp] == "x" || equation[lastOp] == "/") {
      equation = equation.substring(0, lastOp + 1) +
          "-" +
          equation.substring(lastOp + 1);
    }
  }

  void percent() {
    int lastOp;
    String num = "";
    List op = ["+", "-", "*", "/"];
    for (int i = equation.length - 1; i >= 0; i--) {
      if (op.contains(equation[i])) {
        lastOp = i;
        break;
      }
    }
    num = equation.substring(lastOp, equation.length - 1);
    double num1 = double.parse(num) * 100;
    finalResult += num1.toString();
  }
}
