import 'dart:io';

import 'interfaces/Command.dart';
import 'CommandWords.dart';


class RPNCalculator {
  late CommandWords _commandWords;

  RPNCalculator() {
    _commandWords = new CommandWords();
    _printWelcomeMessage();
    _readLine();
  }

  _readLine() {
    while (true) {
      var line = stdin.readLineSync();

      try {
        line = line?.trim().toLowerCase();
      } catch (e) {
        print(e);
      }

      try {
        var number = num.parse(line!); //Try parsing if its a number
        _commandWords.pushToStack(number);
      } on FormatException {
        //If its not a number, continue
        if (_commandWords.isCommand(line!)) {
          //Check if its a command
          try {
            _commandWords.executeCommand();
          } on Exception catch (e) {
            print(e);
          }
        }
      }
    }
  }

  void _printWelcomeMessage() {
    print("Welcome to the RPN Calculator");
    print("Enter a number or a command");
    print("Commands:");
    for (Command command in _commandWords.allCommands) {
      print(command.help());
      print(" ");
    }
  }
}
