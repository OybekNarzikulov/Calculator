import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 50.0;
  double resultFontSize = 70.0;

  calculation(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        equation = '0';
        result = '0';
        double equationFontSize = 50.0;
        double resultFontSize = 70.0;
      } else if (buttonText == '+/-') {
        if (double.parse(equation) > 0.0) {
          result = (double.parse(equation) * -1).toString();
          equation = result;
        } else if (double.parse(equation) < 0.0) {
          result = (double.parse(equation) * -1).toString();
          equation = result;
        }
      } else if (buttonText == '%') {
        equation = (double.parse(equation) / 100).toString();
      } else if (buttonText == '=') {
        double equationFontSize = 50.0;
        double resultFontSize = 70.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = result;
        } catch (e) {
          result = 'ERROR';
        }
      } else {
        if (equation == '0') {
          equation = '';
        }
        equation = equation + buttonText;
      }
    });
  }

  Widget calcbutton(String buttonText, Color buttonColor, Color textColor) {
    return Container(
      child: RaisedButton(
        onPressed: () => calculation(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 35,
            color: textColor,
          ),
        ),
        shape: CircleBorder(),
        color: buttonColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width*0.9,
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      equation,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: equationFontSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width*0.9,
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      result,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: resultFontSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey.shade800, Colors.white),
                calcbutton('8', Colors.grey.shade800, Colors.white),
                calcbutton('9', Colors.grey.shade800, Colors.white),
                calcbutton('x', Colors.amber.shade700, Colors.white),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey.shade800, Colors.white),
                calcbutton('5', Colors.grey.shade800, Colors.white),
                calcbutton('6', Colors.grey.shade800, Colors.white),
                calcbutton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey.shade800, Colors.white),
                calcbutton('2', Colors.grey.shade800, Colors.white),
                calcbutton('3', Colors.grey.shade800, Colors.white),
                calcbutton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                calcbutton('.', Colors.grey.shade800, Colors.white),
                calcbutton('=', Colors.amber.shade700, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
