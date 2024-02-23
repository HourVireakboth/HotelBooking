import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/views/pages/mainpage.dart';
import 'package:hotel_booking_app/widgets/resoponsive_button.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/thanksyou.jpg'))),
        child: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (context) => const MainPageScreen()),
                (route) => false);
          },
          child: Stack(children: [
            Positioned(
              bottom: 100,
              left: 50,
              right: 50,
              child: ResponsiveButton(
              heigh: 63,
              width: 352,
              text: 'Done',
              radius: 50,
              textsize: 25,
              fontWeight: FontWeight.w500,
                      ),
            )
          ]),
        ))
    );
  }
}
