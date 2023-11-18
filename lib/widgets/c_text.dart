import 'package:flutter/material.dart';

class Ctext extends StatelessWidget {
  String text;
  Color color;
  FontWeight fontWeight;
  double fontSize;
  Ctext({super.key, required this.text, this.fontSize = 15, this.fontWeight = FontWeight.normal, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
