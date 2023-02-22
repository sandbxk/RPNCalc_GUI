import 'package:flutter/material.dart';
import 'package:rpn_calc_gui/calc_widget.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorWidget(),
    theme:
        ThemeData(primaryColor: Colors.blueGrey, brightness: Brightness.dark),
    darkTheme:
        ThemeData(primaryColor: Colors.blueGrey, brightness: Brightness.dark),
    themeMode: ThemeMode.dark,
  ));
}
