import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpn_calc_gui/calc_widget.dart';

import 'calc_model.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) => CalcModel(),
        child: CalculatorWidget()),
    theme:
        ThemeData(primaryColor: Colors.blueGrey, brightness: Brightness.dark),
    darkTheme:
        ThemeData(primaryColor: Colors.blueGrey, brightness: Brightness.dark),
    themeMode: ThemeMode.dark,
  ));
}
