import 'package:flutter/material.dart';
import 'package:rpn_calc_gui/calculator/interfaces/Command.dart';

import 'calculator/input_stack.dart';
import 'calculator/interfaces/Operations.dart';
import 'calculator/interfaces/Controls.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final List<Command> _commands = [
    AddCommand(),
    SubCommand(),
    MultiplyCommand(),
    DivCommand(),
    QuitCommand(),
    PrintCommand(),
    ClearCommand(),
    UndoCommand()
  ];

  Command? _currentCommand;
  late InputStack<Command> _inputHistory;
  late InputStack<num> _stack;

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

  void addNumber(int number) {
    setState(() {
      _stack.push(number);
      _textToDisplay = _showCurrentStack();
    });
  }

  void addOperator(Command operator) {
    setState(() {
      _inputHistory.push(operator);
      _currentCommand = operator;
      _textToDisplay = _showCurrentStack();
    });
  }

  void calculate() {
    setState(() {
      try {
        _currentCommand?.execute(_stack, _inputHistory);
        _textToDisplay = _showCurrentStack();
      } catch (e) {
        print(e);
      }
    });
  }

  void clear() {
    setState(() {
      _stack.clear();
      _inputHistory.clear();
      _textToDisplay = _showCurrentStack();
    });
  }

  void undo() {
    setState(() {
      _stack.pop();
      _textToDisplay = _showCurrentStack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              TextButton(onPressed: () => undo(),
                  child: Text("Undo", style: TextStyle(color: Colors.white),)),
            Text(
              _textToDisplay,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ]
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(7),
                      child: Text("7"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(8),
                      child: Text("8"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(9),
                      child: Text("9"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addOperator(DivCommand()),
                      child: Text("/"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(4),
                      child: Text("4"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(5),
                      child: Text("5"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(6),
                      child: Text("6"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addOperator(MultiplyCommand()),
                      child: Text("*"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(1),
                      child: Text("1"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(2),
                      child: Text("2"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addNumber(3),
                      child: Text("3"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addOperator(SubCommand()),
                      child: Text("-"),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ]));
  }
}
