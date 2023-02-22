import 'dart:ffi';
import 'dart:io';

import '../input_stack.dart';
import 'Command.dart';

class QuitCommand extends Command<Void> {
  @override
  Void execute([Void? a, Void? b]) {
    exit(0);
  }

  @override
  String getName() {
    return "Quit";
  }

  @override
  String getSymbol() {
    return "q";
  }

  @override
  String help() {
    return "q: Quit the program";
  }

  @override
  Type getParamType() {
    return Void;
  }
}

class ClearCommand extends Command<InputStack<num>> {
  @override
  InputStack<num> execute([InputStack<num>? numberStack, InputStack<num>? historyStack]) {
    for (int i = 0; i < 5; i++) {
      print("");
    }

    numberStack!.clear();
    historyStack!.clear();

    print("Stack cleared!");

    return numberStack;
  }

  @override
  String getName() {
    return "Clear";
  }

  @override
  String getSymbol() {
    return "c";
  }

  @override
  String help() {
    return "c: Clear the stack";
  }

  @override
  Type getParamType() {
    return InputStack<num>;
  }
}

class PrintCommand extends Command<InputStack<num>> {
  @override
  InputStack<num> execute([InputStack<num>? numberStack, InputStack<num>? historyStack]) {
    if (numberStack != null)
      print("Stack: ${numberStack.toString()}");
    else
      print("Stack: Empty");

    return numberStack!;
  }

  @override
  String getName() {
    return "Print";
  }

  @override
  String getSymbol() {
    return "p";
  }

  @override
  String help() {
    return "p: Print the stack";
  }

  @override
  Type getParamType() {
    return InputStack<num>;
  }
}

class UndoCommand extends Command<InputStack<num>> {
  @override
  InputStack<num> execute([InputStack<num>? numberStack, InputStack<num>? historyStack]) {
    if (!numberStack!.isEmpty && !historyStack!.isEmpty) {
      numberStack.pop();

      num a = historyStack.pop();
      num b = historyStack.pop();

      numberStack.push(a);
      numberStack.push(b);
    }

    return numberStack;
  }

  @override
  String getName() {
    return "Undo";
  }

  @override
  String getSymbol() {
    return "u";
  }

  @override
  String help() {
    return "u: Undo the last operation";
  }

  @override
  Type getParamType() {
    return InputStack<num>;
  }
}
