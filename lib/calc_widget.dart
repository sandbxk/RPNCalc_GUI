import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rpn_calc_gui/calc_button_widget.dart';
import 'package:rpn_calc_gui/calculator/interfaces/Command.dart';
import 'package:rpn_calc_gui/custom_icons_icons.dart';

import 'calculator/input_stack.dart';
import 'calculator/interfaces/Operations.dart';
import 'calculator/interfaces/Controls.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  CalculatorWidgetState createState() => CalculatorWidgetState();
}

//TODO: Add Icon support for buttons

class CalculatorWidgetState extends State<CalculatorWidget> {
  final String helpExplanation =
      "Reverse Polish notation (RPN) is a method for conveying mathematical expressions without the use of separators such as brackets and parentheses. In this notation, the operators follow their operands, hence removing the need for brackets to define evaluation priority. The operation is read from left to right but execution is done every time an operator is reached, and always using the last two numbers as the operands. This notation is suited for computers and calculators since there are fewer characters to track and fewer operations to execute. Reverse Polish notation is also known as postfix notation.";

  Command? _currentCommand;
  late InputStack<num> _inputHistory;
  late InputStack<num> _stack;

  num _currentNumber = 0;
  String _textToDisplay = "0 ?";

  CalculatorWidgetState() {
    _inputHistory = InputStack();
    _stack = InputStack();
  }

  String get currentOperator {
    if (_currentCommand == null) {
      return "?";
    } else {
      return _currentCommand!.getSymbol();
    }
  }

  void addNumber(num number) {
    setState(() {
      if (_currentNumber == 0) {
        _currentNumber = number;
      } else {
        _currentNumber = _currentNumber * 10 + number;
      }
      _textToDisplay = "$_currentNumber $currentOperator";
    });
  }

  void enter() {
    setState(() {
      _stack.push(_currentNumber);
      _inputHistory.push(_currentNumber);
      _currentNumber = 0;
      _textToDisplay = "$_currentNumber $currentOperator";
    });
  }

  void addOperator(Command operator) {
    setState(() {
      _currentCommand = operator;
      calculate();
      _textToDisplay = "$_currentNumber $currentOperator";
    });
  }

  void calculate() {
    setState(() {
      try {
        _stack = _currentCommand!.execute(_stack);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  void clear() {
    setState(() {
      ClearCommand().execute(_stack);
      ClearCommand().execute(_inputHistory);
      _currentCommand = null;
      _currentNumber = 0;

      _textToDisplay = "0 $currentOperator";
    });
  }

  void undo() {
    setState(() {
      _stack = UndoCommand().execute(_stack, _inputHistory);
      _stack.pop();
      _textToDisplay = "0 $currentOperator";
    });
  }

  Future<void> _help() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Help'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(helpExplanation),
                ),
                ListBody(
                  children: const <Widget>[
                    Text('Add: +'),
                    Text('Subtract: -'),
                    Text('Multiply: *'),
                    Text('Divide: /'),
                    Text('Clear: C'),
                    Text('Undo: U'),
                    Text('Enter: ENTER')
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RPN Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: 'Help',
            onPressed: () => _help(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TextButton.icon(
                              onPressed: () => clear(),
                              icon: const Icon(Icons.clear_all),
                              label: const Text("Clear")),
                          Text(
                            _stack.toString(),
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _textToDisplay,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalcButton(
                  text: "1",
                  onPressed: () => addNumber(1),
                ),
                CalcButton(
                  text: "2",
                  onPressed: () => addNumber(2),
                ),
                CalcButton(
                  text: "3",
                  onPressed: () => addNumber(3),
                ),
                CalcButton(
                  icon: Icons.add,
                  onPressed: () => addOperator(AddCommand()),
                  color: Colors.blue,
                  size: 30,
                  text: '',
                  weight: 1000,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalcButton(
                  text: "4",
                  onPressed: () => addNumber(4),
                ),
                CalcButton(
                  text: "5",
                  onPressed: () => addNumber(5),
                ),
                CalcButton(
                  text: "6",
                  onPressed: () => addNumber(6),
                ),
                CalcButton(
                  text: "",
                  icon: CustomIcons.minus,
                  onPressed: () => addOperator(SubCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalcButton(
                  text: "7",
                  onPressed: () => addNumber(7),
                ),
                CalcButton(
                  text: "8",
                  onPressed: () => addNumber(8),
                ),
                CalcButton(
                  text: "9",
                  onPressed: () => addNumber(9),
                ),
                CalcButton(
                  text: "",
                  icon: CustomIcons.multiply,
                  onPressed: () => addOperator(MultiplyCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CalcButton(
                  text: "",
                  icon: Icons.undo,
                  onPressed: () => clear(),
                  color: Colors.blueGrey,
                  size: 30,
                ),
                CalcButton(
                  text: "0",
                  onPressed: () => addNumber(0),
                ),
                CalcButton(
                  text: "",
                  icon: Icons.arrow_right_alt,
                  onPressed: () => enter(),
                  color: Colors.blueGrey,
                  size: 30,
                ),
                CalcButton(
                  text: "",
                  icon: CustomIcons.divide,
                  onPressed: () => addOperator(DivCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
