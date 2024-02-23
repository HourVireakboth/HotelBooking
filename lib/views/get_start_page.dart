
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/misc/fonts.dart';
import 'package:hotel_booking_app/views/welcome_paged.dart';
import 'package:hotel_booking_app/widgets/app_large_text.dart';
import 'package:hotel_booking_app/widgets/app_text.dart';
import 'package:hotel_booking_app/widgets/resoponsive_button.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({Key? key}) : super(key: key);

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  List images = [
    'Welcome_booking1.jpg',
    'Welcome_booking2.jpg',
    'Welcome_booking3.jpg',
  ];
  List text = ['Best Hotel', 'Hotel Entertainment', 'ROOM SERVICE'];

  void navigateToLoginpage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const WelcomePage();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/${images[index]}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.52,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: index == indexDots ? 45 : 45,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index == indexDots
                              ? AppColors.mainTextColor
                              : AppColors.textgrey.withOpacity(0.4),
                        ),
                      );
                    }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                              text: text[index],
                              textsize: 30,
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.w700,
                              fontfamily: AppFontFamilys.libreFrankin,
                              ),
                            AppText(
                              text: "Booking now",
                              textsize: 30,
                              color: AppColors.textblack,
                              fontfamily: AppFontFamilys.libreFrankin,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              width: 250,
                              child: AppText(
                                text: "Welcome to relax my hotel ",
                                color: AppColors.textblack,
                                fontWeight: FontWeight.w400,
                                textsize: 14,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  navigateToLoginpage();
                                },
                                child: ResponsiveButton(
                                  text: 'Get start',
                                  width: 170,
                                  heigh: 53,
                                  textsize: 18,
                                  fontfamily: AppFontFamilys.libreFrankin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
