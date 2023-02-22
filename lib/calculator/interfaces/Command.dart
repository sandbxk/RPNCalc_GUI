
abstract class Command<e> {
  String getName();
  String getSymbol();
  e execute([e a, e b]);
  String help();

  Type getParamType() {
   return e;
  }
}