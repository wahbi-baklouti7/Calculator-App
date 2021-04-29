import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String finalResult = "0";
  String equation = "";
  var buttonColor = Color(0xFFE9F0F4);
  var buttonTextColor = Colors.black;
  var backColor = Colors.white;
  var calcColor = Colors.white;
  var moonColor = Colors.black12;
  var sunColor = Colors.black;

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
      backgroundColor: backColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // dark mode
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.moon,
                            color: moonColor,
                          ),
                          onPressed: () {
                            setState(() {
                              darkMode();
                            });
                          }),

                      // light moon
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.sun,
                            color: sunColor,
                          ),
                          onPressed: () {
                            setState(() {
                              lightMode();
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 5, 0),
                child: Container(
                  // foregroundDecoration: BoxDecoration(color: resultColor),
                  color: backColor,
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        equation,
                        style: TextStyle(fontSize: 18, color: buttonTextColor),
                        maxLines: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(finalResult,
                          style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 39,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    color: calcColor),
                // color: Colors.black54,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                        textColor: buttonTextColor,
                        buttonColor: buttonColor,
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
                        textColor: buttonTextColor,
                        buttonColor: buttonColor,
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
                          : buttonColor,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : buttonTextColor,
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
      if (finalResult.length > 16) {
        finalResult = finalResult.substring(0, 16);
      } 
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
        number = int.parse(
            equation.substring(lastOperatorIndex + 1, equation.length));
        // number = number * -1;
        equation = equation.replaceAll(
            equation.substring(lastOperatorIndex, equation.length),
            ("+" + number.toString()));
      } else if (equation[lastOperatorIndex] == "+") {
        number = int.parse(
            equation.substring(lastOperatorIndex + 1, equation.length));
        number = number * -1;
        equation = equation.replaceAll(
            equation.substring(lastOperatorIndex), number.toString());
      } else {
        number = int.parse(
            equation.substring(lastOperatorIndex + 1, equation.length));
        number = number * -1;
        equation =
            equation.substring(0, lastOperatorIndex + 1) + number.toString();
      }
    }
  }

  // percentage button
  void percent() {
    double num1;
    int lastOperatorIndex = lastOperator();
    num1 = double.parse(
        equation.substring(lastOperatorIndex + 1, equation.length));
    equation = equation.substring(0, lastOperatorIndex + 1) +
        equation.substring(lastOperatorIndex + 1, equation.length) +
        "%";
    num1 = num1 / 100;
    equation = equation.replaceAll(
        equation.substring(lastOperatorIndex + 1, equation.length),
        num1.toString());
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

  void darkMode() {
    buttonColor = Colors.black87;
    buttonTextColor = Colors.white;
    backColor = Color(0xFF2B2F37);
    calcColor = Color(0xFF22252D);
    moonColor = Colors.white;
    sunColor = Colors.white12;
  }

  void lightMode() {
    buttonColor = Color(0xFFE9F0F4);
    buttonTextColor = Colors.black;
    backColor = Colors.white;
    calcColor = Colors.white;
    moonColor = Colors.black12;
    sunColor = Colors.black;
  }
}
