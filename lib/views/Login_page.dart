import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/misc/fonts.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/forgetpassword.dart';
import 'package:hotel_booking_app/views/pages/mainpage.dart';
import 'package:hotel_booking_app/views/signup_page.dart';
import 'package:hotel_booking_app/widgets/app_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../misc/colors.dart';
import '../widgets/resoponsive_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userViewModel = UserViewModel();
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var _isobscured;
  var isLogin;

  @override
  void initState() {
    userViewModel = UserViewModel();
    _isobscured = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Background.jpg'),
                fit: BoxFit.cover)),
      ),
      Container(
        height: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Logo_hotel12.png'),
              fit: BoxFit.cover),
        ),
      ),
      ChangeNotifierProvider<UserViewModel>(
        create: (context) => userViewModel,
        child: Consumer<UserViewModel>(
          builder: (context, viemModel, _) {
            var status = viemModel.apiResponse.status;
            print('status ${status}');
            if (status == Status.COMPLETED) {
              var token = viemModel.apiResponse.data!.user!.token;
              var userID = viemModel.apiResponse.data!.user!.id;
              checkauth(token.toString(), userID.toString());
              saveuser(email.text, password.text);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => const MainPageScreen()),(context) => false);
              });
            } else if (status == Status.ERROR) {
              if (isLogin == true) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${viemModel.apiResponse.message}')));
                  setState(() {
                    isLogin = false;
                  });
                });
              }
            }
            return CustomScrollView(
              anchor: 0.4,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50)),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: AppColors.mainTextColor,
                          style: BorderStyle.solid,
                        )),
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.maxFinite,
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AppText(
                        text: 'Login',
                        textsize: 30,
                        fontfamily: AppFontFamilys.libreFrankin,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColor,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: SizedBox(
                          child: Form(
                            key: globalkey,
                            child: TextFormField(
                              validator: (useremail) {
                                if (useremail!.isEmpty) {
                                  return 'Please enter Email';
                                } else {
                                  if (extString(useremail).isValidEmail) {
                                    return null;
                                  } else {
                                    return 'Invaild Fomat Email';
                                  }
                                }
                              },
                              onChanged: (value) {
                                if (globalkey.currentState!.validate()) {
                                  globalkey.currentState!.save();
                                }
                              },
                              onFieldSubmitted: (userInput) {
                                if (globalkey.currentState!.validate()) {
                                  globalkey.currentState!.save();
                                }
                              },
                              controller: email,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.mainTextColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.mainTextColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.mainTextColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: SizedBox(
                          child: Form(
                            key: globalkey_two,
                            child: TextFormField(
                              validator: (userpassword) {
                                if (userpassword!.isEmpty) {
                                  return 'Please enter password';
                                } else {
                                  if (extString(userpassword).isValidPassword) {
                                    return null;
                                  } else {
                                    return 'Invaild Password';
                                  }
                                }
                              },
                              onChanged: (value) {
                                if (globalkey_two.currentState!.validate()) {
                                  globalkey_two.currentState!.save();
                                }
                              },
                              onFieldSubmitted: (userInput) {
                                if (globalkey_two.currentState!.validate()) {
                                  globalkey_two.currentState!.save();
                                }
                              },
                              obscureText: _isobscured,
                              controller: password,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                                labelText: 'Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: AppColors.mainTextColor,
                                ),
                                suffixIcon: IconButton(
                                    color: AppColors.mainTextColor,
                                    onPressed: () {
                                      setState(() {
                                        _isobscured = !_isobscured;
                                      });
                                    },
                                    icon: _isobscured
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.mainTextColor),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.mainTextColor),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          print(email.text);
                          print(password.text);
                          if (email.text != "" && password.text != "") {
                            userViewModel.postUser(email.text, password.text);
                            isLogin = true;
                          } else {
                            // WidgetsBinding.instance
                            //     .addPostFrameCallback((timeStamp) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text(
                            //               ' email & password can not be')));
                            // });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  content: Container(
                                    margin: EdgeInsets.zero,
                                    height: 120,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.zero,
                                          height: 70,
                                          width: 70,
                                          child: Image.asset(
                                              'assets/images/error.png'),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Please Fill Email and Password!',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                foregroundColor:
                                                    AppColors.buttonBackground,
                                                backgroundColor:
                                                    AppColors.mainTextColor),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Okay',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: ResponsiveButton(
                          width: 171,
                          heigh: 42,
                          text: 'Login',
                          fontWeight: FontWeight.w500,
                          fontfamily: AppFontFamilys.libreFrankin,
                          textsize: 18,
                          radius: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          print('go to Forget password');
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const ForgetPasswordPage();
                          }));
                        },
                        child: AppText(
                          text: 'Forget password?',
                          textsize: 18,
                          fontfamily: AppFontFamilys.libreFrankin,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText(
                        text: 'Or',
                        textsize: 19,
                        fontfamily: AppFontFamilys.libreFrankin,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 15, 80, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 45,
                                child: InkWell(
                                    onTap: () {
                                      print('Login with facebook');
                                    },
                                    child: Image.asset(
                                        'assets/images/facebook.png'))),
                            SizedBox(
                                height: 45,
                                child: InkWell(
                                    onTap: () {
                                      print('Login with google');
                                    },
                                    child: Image.asset(
                                        'assets/images/google-plus.png'))),
                            SizedBox(
                                height: 45,
                                child: InkWell(
                                    onTap: () {
                                      print('Login with Apple');
                                    },
                                    child:
                                        Image.asset('assets/images/apple.png')))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: 'Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFontFamilys.libreFrankin,
                                  color: AppColors.mainTextColor),
                            ),
                            TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppFontFamilys.libreFrankin,
                                    color: AppColors.mainTextColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    debugPrint('go to Sign Up');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const SignUpPage();
                                    }));
                                  }),
                          ]))),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ])));
  }

  void checkauth(tokens, userID) async {
    print("check prefer");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('tokens:$tokens');
    print('password:$userID');
    prefs.setString('token', tokens);
    prefs.setString('userID', userID);
  }

  void saveuser(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('email:$email');
    print('password:$password');
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('getstart', true);
  }
}
