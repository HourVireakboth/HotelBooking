import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/views/pages/booking/booking.dart';
import 'package:hotel_booking_app/views/pages/category/category.dart';
import 'package:hotel_booking_app/views/pages/home/home.dart';
import 'package:hotel_booking_app/views/pages/profile/profile.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  // String? email;
  // String? password;
  int currentPage = 0;
  // var userviewModel = UserViewModel();
  // Future getValidationData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var emails = prefs.getString('email');
  //   var passwords = prefs.getString('password');
  //   print('email:$emails');
  //   print('pw:$passwords');
  //   setState(() {
  //     email = emails;
  //     password = passwords;
  //   });
  // }

  List<Widget> pages = const [
    HomeScreenPage(),
    BookingScreenPage(),
    CategoryScreenPage(),
    ProfileScreenPage(),
  ];
  // @override
  // void initState() {
  //   getValidationData().whenComplete(() {
  //     userviewModel = UserViewModel();
  //     getDataUser(email, password);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(0),
        height: size.height * 0.08,
        //margin: EdgeInsets.fromLTRB(10,20,10,0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: GNav(
            haptic: false,
            backgroundColor: AppColors.mainTextColor,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            iconSize: 30,
            tabMargin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(10),
            selectedIndex: currentPage,
            onTabChange: (index) {
              setState(() {
                currentPage = index;
              });
            },
            mainAxisAlignment: MainAxisAlignment.center,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.book,
                text: 'Booking',
              ),
              GButton(
                icon: Icons.category,
                text: 'Category',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void getDataUser(email, password) async {
  //   print('email:$email');
  //   print('password$password');
  //   await userviewModel.postUser(email.toString(), password.toString());
  //   print('status: ${userviewModel.apiResponse.status}');
  //   print('error: ${userviewModel.apiResponse.message}');
  // }
}
