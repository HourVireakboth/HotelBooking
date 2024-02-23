import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  double? textsize;
  String? text;
  Color? color;
  FontWeight? fontWeight;
  String? fontfamily;
  AppText(
      {Key? key,
      required this.text,
      this.color = Colors.black54,
      this.textsize = 16,
      this.fontWeight = FontWeight.normal,
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
        fontFamily: fontfamily,
        fontWeight: fontWeight
      ),
    );
  }
}
