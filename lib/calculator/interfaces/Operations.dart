import 'Command.dart';

class AddCommand implements Command<num> {


  @override
  num execute([num? a, num? b]) {
    if (a == null || b == null)
      throw new Exception("Missing arguments for multiplication");
    return a + b;
  }

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

}

class SubCommand implements Command<num> {

  @override
  num execute([num? a, num? b]) {
    if (a == null || b == null)
      throw new Exception("Missing arguments for multiplication");
    return a - b;
  }

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

}

class MultiplyCommand implements Command<num> {
  @override
  num execute([num? a, num? b]) {
    if (a == null || b == null)
      throw new Exception("Missing arguments for multiplication");
    return a * b;
  }

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

}

class DivCommand implements Command<num> {
  @override
  num execute([num? a, num? b]) {
    if (a == null || b == null)
      throw new Exception("Missing arguments for multiplication");
    return a / b;
  }

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

}
