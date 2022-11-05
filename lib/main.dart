import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calulator",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  String result = "0";
  String equation = "0";
  String expression = " ";
  double equaitionFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPresssed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equaitionFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equaitionFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equaitionFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equaitionFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildbutton(
      String buttonText, double butttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.2 * butttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
        ),
        onPressed: () => buttonPresssed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Simple Calulator')),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equaitionFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildbutton("C", 1, Colors.redAccent),
                          buildbutton("⌫", 1, Colors.blue),
                          buildbutton("÷", 1, Colors.redAccent),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildbutton("7", 1, Colors.black54),
                          buildbutton("8", 1, Colors.black54),
                          buildbutton("9", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildbutton("4", 1, Colors.black54),
                          buildbutton("5", 1, Colors.black54),
                          buildbutton("6", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildbutton("1", 1, Colors.black54),
                          buildbutton("2", 1, Colors.black54),
                          buildbutton("3", 1, Colors.black54),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildbutton(".", 1, Colors.black54),
                          buildbutton("0", 1, Colors.black54),
                          buildbutton("00", 1, Colors.black54),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildbutton("×", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildbutton("-", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildbutton("+", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildbutton("=", 2, Colors.redAccent),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
