import 'package:flutter/material.dart';

class CalcButton extends Material {
  CalcButton(
      {Key? key,
      required String text,
      required VoidCallback onPressed,
      Color? color,
      IconData? icon,
      double? size,
      double? weight})
      : super(
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
                child: LayoutBuilder(builder: (p0, p1) {
                  if (icon == null) {
                    return Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    );
                  } else {
                      double iconSize = 25;

                      if (size != null) {
                        iconSize = size;
                      }

                    return RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: Icon(icon, size: iconSize, weight: weight,
                          ),
                        ),
                      ]),
                    );
                  }
                }),
              ),
            ),
          ),
        );
}
