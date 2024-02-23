import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';


// ignore: must_be_immutable
class ResponsiveButton extends StatefulWidget {
  bool? isResponsive;
  double? width;
  double? heigh;
  String? text;
  double? textsize;
  double? radius;
  String? fontfamily;
  FontWeight? fontWeight;
  Color? color;
  ResponsiveButton(
      {Key? key,
      this.isResponsive,
      this.width,
      this.heigh = 60,
      this.text,
      this.textsize = 16,
      this.radius = 10,
      this.fontfamily,
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.mainTextColor
      })
      : super(key: key);

  @override
  State<ResponsiveButton> createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.heigh,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius!),
          color: widget.color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text!,
            style: TextStyle(
                color: AppColors.buttonBackground,
                fontSize: widget.textsize,
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontfamily),
          ),
        ],
      ),
    );
  }
}
