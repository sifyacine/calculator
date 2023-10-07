import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String user_input = '';
  String result = '0';
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1D2630),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'yacine\'s calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    user_input,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: buttonList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return customButton(buttonList[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(String texxt) {
    return InkWell(
      splashColor: Color(0xFF1D2630),
      onTap: () {
        setState(() {
          handleButtons(texxt);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3), // Use Offset here
            ),
          ],
        ),
        child: Center(
          child: Text(
            texxt,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: getColor(texxt),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(String text) {
    if (text == "/" || text == "+" || text == "-" || text == "*" || text == "C" || text == "(" || text == ")") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "AC") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return Color.fromARGB(255, 150, 204, 150);
    }
    return Color(0xFF1D2630);
  }

  void handleButtons(String text) {
    if (text == 'AC') {
      user_input = '';
      result = '0';
    } else if (text == 'C') {
      if (user_input.isNotEmpty) {
        user_input = user_input.substring(0, user_input.length - 1);
      }
    } else if (text == '=') {
      result = calculate();
      if (user_input.endsWith(".0")) {
        user_input = user_input.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
    } else {
      user_input = user_input + text; // Only add text to user_input when it's not AC, C, or =
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(user_input); // Corrected the syntax here
      var result = exp.evaluate(EvaluationType.REAL, ContextModel());

      return result.toString();
    } catch (e) {
      return "error";
    }
  }
}
