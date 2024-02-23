import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:hotel_booking_app/views/pages/profile/edit_profile.dart';
import 'package:hotel_booking_app/views/pages/profile/help.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../misc/colors.dart';
import '../../../viewmodels/user_viewmodel.dart';
import 'favorite.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  String? email;
  String? password;
  String? token;
  int currentPage = 0;
  var userviewModel = UserViewModel();
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var emails = prefs.getString('email');
    var passwords = prefs.getString('password');
    var tokens = prefs.getString('token');
    print('email:$emails');
    print('pw:$passwords');
    print('token:$tokens');
    setState(() {
      email = emails;
      password = passwords;
      token = tokens;
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() {
      userviewModel = UserViewModel();
      getDataUser(email, password);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userviewModel.apiResponse.status == Status.COMPLETED
        ? Scaffold(
            backgroundColor: AppColors.buttonBackground,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.buttonBackground,
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainTextColor),
              ),
            ),
            body: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 233,
                        width: 233,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: userviewModel
                                            .apiResponse.data!.user!.profile
                                            .toString() ==
                                        "http://127.0.0.1:8000/Users/Boy.png"
                                    ? NetworkImage(
                                        '${userviewModel.apiResponse.data!.user!.profile}')
                                    : NetworkImage(
                                        'http://127.0.0.1:8000/profile/${userviewModel.apiResponse.data!.user!.profile}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Text(
                        '${userviewModel.apiResponse.data!.user!.name}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      users:
                                          userviewModel.apiResponse.data?.user,
                                      token: token,
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.mainTextColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.settings,
                              color: AppColors.mainTextColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: const Text(
                              'Setting',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: AppColors.mainTextColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: const Text(
                              'Notification',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => FavoriteScreen(token: token,)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite_border_outlined,
                                color: AppColors.mainTextColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              child: const Text(
                                'Favorite',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const HelpScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.help_outline,
                                color: AppColors.mainTextColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              child: const Text(
                                'Help',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        prefs.remove('userID');
                        prefs.remove('email');
                        prefs.remove('password');

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, bottom: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.logout,
                                color: AppColors.mainTextColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void getDataUser(email, password) async {
    print('email:$email');
    print('password$password');
    await userviewModel.postUser(email.toString(), password.toString());
    print('status: ${userviewModel.apiResponse.status}');
    print('error: ${userviewModel.apiResponse.message}');
    setState(() {});
  }
}
