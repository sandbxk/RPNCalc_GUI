import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rpn_calc_gui/calculator/input_stack.dart';

import 'calculator/interfaces/Command.dart';

class CalcModel extends ChangeNotifier {

  String _textToDisplay = "0 ?";
  String get textToDisplay => _textToDisplay;
  final String helpExplanation =
      "Reverse Polish notation (RPN) is a method for conveying mathematical expressions without the use of separators such as brackets and parentheses. In this notation, the operators follow their operands, hence removing the need for brackets to define evaluation priority. The operation is read from left to right but execution is done every time an operator is reached, and always using the last two numbers as the operands. This notation is suited for computers and calculators since there are fewer characters to track and fewer operations to execute. Reverse Polish notation is also known as postfix notation.";



  void setTextToDisplay(String text) {
    _textToDisplay = text;
    notifyListeners();
  }

  num _currentNumber = 0;

  num get currentNumber => _currentNumber;

  void setCurrentNumber(num number) {
    _currentNumber = number;
    notifyListeners();
  }

  Command? _currentOperator;

  Command? get currentCommand => _currentOperator;

  void setCurrentCommand(Command? command) {
    _currentOperator = command;
    notifyListeners();
  }

  InputStack<num> _stack = InputStack<num>();

  InputStack<num> get stack => _stack;

  void setStack(InputStack<num> stack) {
    _stack = stack;
    notifyListeners();
  }

  InputStack<num> _inputHistory = InputStack<num>();

  InputStack<num> get inputHistory => _inputHistory;

  void setInputHistory(InputStack<num> inputHistory) {
    _inputHistory = inputHistory;
    notifyListeners();
  }

  void addNumber(num number) {
    if (_currentNumber == 0) {
      _currentNumber = number;
    } else {
      _currentNumber = _currentNumber * 10 + number;
    }
    _textToDisplay = "$_currentNumber $_currentOperator";
    notifyListeners();
  }

  void enter() {
    _stack.push(_currentNumber);
    _inputHistory.push(_currentNumber);
    _currentNumber = 0;
    _textToDisplay = "$_currentNumber $_currentOperator";
    notifyListeners();
  }

  void addOperator(Command operator) {
    _currentOperator = operator;
    calculate();
    _textToDisplay = "$_currentNumber $_currentOperator";
    notifyListeners();
  }

  void calculate() {
    try {
      _stack = _currentOperator!.execute(_stack);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  clear() {
    _currentNumber = 0;
    _currentOperator = null;
    _stack = InputStack<num>();
    _inputHistory = InputStack<num>();
    _textToDisplay = "$_currentNumber $_currentOperator";
    notifyListeners();
  }

}
