import 'package:rpn_calc_gui/calculator/input_stack.dart';

import 'Command.dart';

class AddCommand implements Command<InputStack<num>> {
  @override
  String getName() {
    return "Addition";
  }

  @override
  String getSymbol() {
    return "+";
  }

  @override
  String help() {
    return "+: Addition operation";
  }

  @override
  Type getParamType() {
    return num;
  }

  @override
  InputStack<num> execute(InputStack<num> input) {
    if (!input.isEmpty) {
      num a = input.pop();
      num b = input.pop();

      num result = a + b;

      input.push(result);
    }

    return input;
  }
}

class SubCommand implements Command<InputStack<num>> {


  @override
  String getName() {
    return "Subtraction";
  }

  @override
  String getSymbol() {
    return "-";
  }

  @override
  String help() {
    return "-: Subtraction operation";
  }

  @override
  Type getParamType() {
    return num;
  }

  @override
  InputStack<num> execute(InputStack<num> input) {
    if (!input.isEmpty) {
      num a = input.pop();
      num b = input.pop();

      num result = a - b;

      input.push(result);
    }

    return input;
  }
}

class MultiplyCommand implements Command<InputStack<num>> {
  @override
  String getName() {
    return "Multiplication";
  }

  @override
  String getSymbol() {
    return "*";
  }

  @override
  String help() {
    return "*: Multiplication operation";
  }

  @override
  Type getParamType() {
    return num;
  }

  @override
  InputStack<num> execute(InputStack<num> numberStack) {
    if (!numberStack.isEmpty) {
      num a = numberStack.pop();
      num b = numberStack.pop();

      num result = a * b;

      numberStack.push(result);
    }

    return numberStack;
  }
}

class DivCommand implements Command<InputStack<num>> {


  @override
  String getName() {
    return "Division";
  }

  @override
  String getSymbol() {
    return "/";
  }

  @override
  String help() {
    return "/: Division operation";
  }

  @override
  Type getParamType() {
    return num;
  }

  @override
  InputStack<num> execute(InputStack<num> input) {
    if (!input.isEmpty) {
      num a = input.pop();
      num b = input.pop();

      num result = b / a;

      input.push(result);
    }

    return input;
  }
}
