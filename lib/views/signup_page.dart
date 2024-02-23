

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:provider/provider.dart';
import '../misc/colors.dart';
import '../widgets/resoponsive_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var globalkey_three = GlobalKey<FormState>();
  var globalkey_four = GlobalKey<FormState>();
  var globalkey_five = GlobalKey<FormState>();
  var _isobscurepassword;
  var _isobscureconpassword;
  var userviewModel;
  var isSignUp;

  @override
  void initState() {
    // TODO: implement initState
    userviewModel = UserViewModel();
    _isobscurepassword = true;
    _isobscureconpassword = true;
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
        create: (context) => userviewModel,
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            var status = viewModel.apiResponse.status;
            print('status:$status');
            if (status == Status.COMPLETED) {
              status = Status.LOADING;
              if (isSignUp == true) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Register account have been Successfully.')));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Please Check your Email and Verify your account to get Login Successful.')));
                  setState(() {
                    isSignUp = false;
                  });
                });
              }
              clear();
            } else if (status == Status.ERROR) {
              if (isSignUp == true) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Your email already have!')));
                  setState(() {
                    isSignUp = false;
                  });
                });
              }
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: globalkey,
                              child: TextFormField(
                                validator: (username) {
                                  if (username!.isEmpty) {
                                    return 'Please enter Name';
                                  } else {
                                    if (extString(username).isValidName) {
                                      return null;
                                    } else {
                                      return 'Invaild Name';
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
                                controller: name,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Name',
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: AppColors.mainTextColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.mainTextColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: globalkey_two,
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
                                  if (globalkey_two.currentState!.validate()) {
                                    globalkey_two.currentState!.save();
                                  }
                                },
                                onFieldSubmitted: (userInput) {
                                  if (globalkey_two.currentState!.validate()) {
                                    globalkey_two.currentState!.save();
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
                                        width: 1,
                                        color: AppColors.mainTextColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: globalkey_three,
                              child: TextFormField(
                                validator: (userpassword) {
                                  if (userpassword!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (extString(userpassword)
                                        .isValidPassword) {
                                      return null;
                                    } else {
                                      return 'Invaild Password';
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  if (globalkey_three.currentState!
                                      .validate()) {
                                    globalkey_three.currentState!.save();
                                  }
                                },
                                onFieldSubmitted: (userInput) {
                                  if (globalkey_three.currentState!
                                      .validate()) {
                                    globalkey_three.currentState!.save();
                                  }
                                },
                                obscureText: _isobscurepassword,
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
                                          _isobscurepassword =
                                              !_isobscurepassword;
                                        });
                                      },
                                      icon: _isobscurepassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.mainTextColor),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: globalkey_four,
                              child: TextFormField(
                                validator: (userconfirmpassword) {
                                  if (userconfirmpassword!.isEmpty) {
                                    return 'Please enter password';
                                  } else {
                                    if (confirmpassword.text == password.text) {
                                      return null;
                                    } else {
                                      return 'Password must be same as above';
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  if (globalkey_four.currentState!.validate()) {
                                    globalkey_four.currentState!.save();
                                  }
                                },
                                onFieldSubmitted: (userInput) {
                                  if (globalkey_four.currentState!.validate()) {
                                    globalkey_four.currentState!.save();
                                  }
                                },
                                obscureText: _isobscureconpassword,
                                controller: confirmpassword,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Confirm Password',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: AppColors.mainTextColor,
                                  ),
                                  suffixIcon: IconButton(
                                      color: AppColors.mainTextColor,
                                      onPressed: () {
                                        setState(() {
                                          _isobscureconpassword =
                                              !_isobscureconpassword;
                                        });
                                      },
                                      icon: _isobscureconpassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.mainTextColor),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    print('name:${name.text}');
                                    print('email:${email.text}');
                                    print('password:${password.text}');
                                    if (name.text.isEmpty &&
                                        email.text.isEmpty &&
                                        password.text.isEmpty &&
                                        confirmpassword.text.isEmpty) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Missing some Input please Input all Information! ')));
                                      });
                                    } else if (!(extString(name.text)
                                        .isValidName)) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Invalid Name Format! (Ex: Vireak both)')));
                                      });
                                    } else if (!(extString(email.text)
                                        .isValidEmail)) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Invalid Format Email!')));
                                      });
                                    } else if (!(extString(password.text)
                                        .isValidPassword)) {
                                      if (password.text.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Missing Input Password!')));
                                        });
                                      } else {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Invaild Format Password!(Password required : capital ,letter , symbol ,number )')));
                                        });
                                      }
                                    } else if (confirmpassword.text !=
                                        password.text) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'ConFirm password  the same password!')));
                                      });
                                    } else {
                                      userviewModel.registerUser(
                                          name.text, email.text, password.text);
                                      isSignUp = true;
                                    }
                                  },
                                  child: ResponsiveButton(
                                    width: 170,
                                    heigh: 45,
                                    text: 'Sign up',
                                    textsize: 20,
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: 'Already have an account?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.mainTextColor),
                                  ),
                                  TextSpan(
                                      text: '  Login',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainTextColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          debugPrint('go to Login');
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()),
                                              (route) => false);
                                        }),
                                ]))),
                          ]),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ])));
  }

  void clear() {
    name.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
  }
}
