import 'dart:ffi';

import 'input_stack.dart';
import 'interfaces/Command.dart';
import 'interfaces/Controls.dart';
import 'interfaces/Operations.dart';

class CommandWords {
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
  late InputStack<num> _inputHistory;
  late InputStack<num> _stack;

  CommandWords() {
    _inputHistory = new InputStack();
    _stack = new InputStack();
  }

  void executeCommand() {
    final _currentCommand = this._currentCommand;
    dynamic output;

    if (_currentCommand != null) {
      try {
        switch (_currentCommand.getParamType()) {
          case num:
            num a = _stack.pop();
            num b = _stack.pop();

            output = _currentCommand.execute(a, b);

            _inputHistory.push(a);
            _inputHistory.push(b);
            break;
          case InputStack<num>:
            _currentCommand.execute(_stack, _inputHistory);
            break;
          case Void:
            _currentCommand.execute();
            break;
          default:
            print("Could not find command. Please try again");
        }
      } catch (e) {
        print(e);
      }
    } else
      throw new Exception(
          "Could not find the current command. Please try again");

    if (output is num) _stack.push(output);
  }

  get allCommands => _commands;

  applyCommand(Command command) {
    _currentCommand = command;
  }

  bool isCommand(String line) {
    try {
      Command cmdFromInput = _commands
          .where((command) =>
              command.getName() == line || command.getSymbol() == line)
          .first;
      _currentCommand = cmdFromInput;

      return true;
    } catch (Exception) {
      return false;
    }
  }

  String _showCurrentStack() {
    String stack = this._stack.toString();

    String currentCommand = _currentCommand?.getSymbol() ?? "?";

    String output = stack.padLeft(5) + currentCommand.padRight(5);

    return output;
  }

  String pushToStack(num input) {
    try {
      _stack.push(input);
      return _showCurrentStack();

    } catch (e) {
      return "Error: $e";
    }
  }
}
