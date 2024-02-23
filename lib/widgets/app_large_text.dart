import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppLargeText extends StatelessWidget {
  double textsize;
  String? text;
  Color? color;
  FontWeight? fontWeight;
  String? fontfamily;
  AppLargeText(
      {Key? key,
      this.text,
      this.color = Colors.black,
      this.textsize = 30,
      this.fontWeight,
      this.fontfamily
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: textsize,
        fontWeight: fontWeight,
        fontFamily: fontfamily
      ),
    );
  }
}
