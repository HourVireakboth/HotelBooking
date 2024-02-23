import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:hotel_booking_app/views/get_start_page.dart';
import 'package:hotel_booking_app/views/pages/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NL1fxFvNJihYHXJMdmRN9rxx3rcb7wNmetz9xuzzyWqx5PyLVtY5PN4MGS6sClp3LqP5Y6FWN638tUBKu12LNhq00HO3qFku5";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel SA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              primary: AppColors.mainTextColor, seedColor: Colors.black12),
        ),
        home: const SplashScreen());
  }
}

String? finaltoken;
String? finaluserID;
bool? finalgetStart;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userID = prefs.getString('userID');
    var email = prefs.getString('email');
    var password = prefs.getString('password');
    var getstart = prefs.getBool('getstart');
    print('token: $token');
    print('userID:$userID');
    print('email: $email');
    print('pw:$password');
    setState(() {
      finaltoken = token;
      finaluserID = userID;
      finalgetStart = getstart;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (ctx) {
          if (finalgetStart == null) {
            return const GetStartPage();
          } else if (finaltoken == null) {
            return const LoginPage();
          } else {
            return const MainPageScreen();
          }
        }));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainTextColor,
      body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Container(
            child: Image.asset(
              'assets/images/SplashScreenjpg.jpg',
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
