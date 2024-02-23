import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwiperCardRoom extends StatefulWidget {
  SwiperCardRoom({super.key, this.listurl});
  var listurl;
  @override
  State<SwiperCardRoom> createState() => _SwiperCardRoomState();
}

class _SwiperCardRoomState extends State<SwiperCardRoom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(30),
        child: Image.network('${widget.listurl}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
