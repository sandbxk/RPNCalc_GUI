import '../input_stack.dart';
import 'Command.dart';


class ClearCommand extends Command<InputStack<dynamic>> {
  @override
  InputStack<dynamic> execute(InputStack<dynamic>? stack) {
    stack!.clear();

    return stack;
  }

  @override
  String getName() {
    return "Clear";
  }

  @override
  String getSymbol() {
    return "C";
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
