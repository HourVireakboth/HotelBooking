import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/misc/fonts.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:hotel_booking_app/views/signup_page.dart';
import 'package:hotel_booking_app/widgets/resoponsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Background.jpg'),
                  fit: BoxFit.cover)),
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Logo_hotel12.png'),
                      fit: BoxFit.cover
                      ),
                  //borderRadius: BorderRadius.all(Radius.circular(500))
                      ),
            ),
            const SizedBox(
              height: 45,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                color: AppColors.buttonBackground,
                fontFamily: AppFontFamilys.khmer_cn_kselus,
                fontSize: 50,
              ),
            )
          ],
        ),
        CustomScrollView(
          //physics: const  BouncingScrollPhysics(),
          physics: const NeverScrollableScrollPhysics(),
          anchor: 0.55,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.maxFinite,
                child: Column(children: [
                  const SizedBox(
                    height: 90,
                  ),
                  InkWell(
                    onTap: (){
                          debugPrint('go to Login');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
                    },
                    child: ResponsiveButton(
                      radius: 50,
                      width: 284,
                      text: 'Login',
                      heigh: 51,
                      textsize: 25,
                      fontfamily: AppFontFamilys.libreFrankin,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: (){
                      debugPrint('go to Sign Up');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignUpPage();
                                }));
                    },
                    child: ResponsiveButton(
                        radius: 50,
                        width: 284,
                        text: 'Sign up',
                        heigh: 51,
                        textsize: 25,
                        fontfamily: AppFontFamilys.libreFrankin,
                        fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: AppColors.mainTextColor),
                        ),
                        TextSpan(
                            text: 'Register',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainTextColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint('go to Sign Up');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignUpPage();
                                }));
                              }),
                      ])))
                ]),
              ),
            )
          ],
        )
      ],
    ));
  }
}
