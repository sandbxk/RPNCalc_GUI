
abstract class Command<e> {
  String getName();
  String getSymbol();
  e execute(e input);
  String help();

  Type getParamType() {
   return e;
  }
}