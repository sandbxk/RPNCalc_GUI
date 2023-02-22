import 'package:flutter/material.dart';
import 'package:rpn_calc_gui/calc_button_widget.dart';
import 'package:rpn_calc_gui/calculator/interfaces/Command.dart';

import 'calculator/input_stack.dart';
import 'calculator/interfaces/Operations.dart';
import 'calculator/interfaces/Controls.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

//TODO: Make buttons bigger and
// fix textDisplay along with buttons in text display
// Make stack display in top left corner with smaller font

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final List<Command> _commands = [
    AddCommand(),
    SubCommand(),
    MultiplyCommand(),
    DivCommand(),
    ClearCommand(),
    UndoCommand()
  ];



  Command? _currentCommand;
  late InputStack<Command> _inputHistory;
  late InputStack<num> _stack;

  num _currentNumber = 0;
  String _textToDisplay = "0";

  _CalculatorWidgetState() {
    _inputHistory = new InputStack();
    _stack = new InputStack();
  }

  String _showCurrentStack() {
    String stack = this._stack.toString();

    String currentCommand = _currentCommand?.getSymbol() ?? "?";

    String output = stack.padLeft(5) + currentCommand.padRight(5);

    return output;
  }

  void addNumber(num number) {
    setState(() {
      if (_currentNumber == 0) {
        _currentNumber = number;
      } else {
        _currentNumber = _currentNumber * 10 + number;
      }
      _textToDisplay = _showCurrentStack() + " | " + _currentNumber.toString();
    });
  }

  void enter() {
    setState(() {
      _stack.push(_currentNumber);
      _currentNumber = 0;
      _textToDisplay = _showCurrentStack() + _currentNumber.toString();
    });
  }

  void addOperator(Command operator) {
    setState(() {
      _inputHistory.push(operator);
      _currentCommand = operator;
      calculate();
      _textToDisplay = _showCurrentStack();
    });
  }

  void calculate() {
    setState(() {
      try {
        _stack = _currentCommand!.execute(_stack);
      } catch (e) {
        print(e);
      }
    });
  }

  void clear() {
    setState(() {
      ClearCommand().execute(_stack);
      ClearCommand().execute(_inputHistory);
      _currentCommand = null;
      _currentNumber = 0;

      _textToDisplay = _showCurrentStack();
    });
  }

  void undo() {
    setState(() {
      _stack.pop();
      _textToDisplay = _showCurrentStack();
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
            child: ListBody(
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
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () => undo(),
                        icon: const Icon(Icons.undo),
                        label: Text("")),
                  ),
                  Text(
                    _textToDisplay,
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                        onPressed: () => clear(),
                        icon: const Icon(Icons.clear),
                        label: Text("")
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  text: "+",
                  onPressed: () => addOperator(AddCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  text: "-",
                  onPressed: () => addOperator(SubCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  text: "*",
                  onPressed: () => addOperator(MultiplyCommand()),
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton(
                  text: "C",
                  onPressed: () => clear(),
                  color: Colors.blue,
                ),
                CalcButton(
                  text: "0",
                  onPressed: () => addNumber(0),
                ),
                CalcButton(
                  text: "ENTER",
                  onPressed: () => enter(),
                  color: Colors.blue,
                ),
                CalcButton(
                  text: "/",
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
