import 'package:flutter/material.dart';


class CalcButton extends Material {


  CalcButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    Color? color
  }) : super(
          key: key,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonTheme(
              minWidth: 75,
              height: 75,
              child: MaterialButton(
                onPressed: onPressed,
                color: color,
                child: Text(text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),

        );


}