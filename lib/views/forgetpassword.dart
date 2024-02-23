import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:hotel_booking_app/views/restpassword.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../misc/colors.dart';
import '../widgets/resoponsive_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  var isCheckEmail = false;
  var isCheckCode = false;
  var isErro;
  var status;
  var globalkey = GlobalKey<FormState>();
  var globakey_one = GlobalKey<FormState>();
  var email = TextEditingController();
  var code = TextEditingController();
  var userviewModel = UserViewModel();
  var isobscured;
  var isSend;
  @override
  void initState() {
    isobscured = true;
    userviewModel = UserViewModel();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   userviewModel.dispose();
  //   super.dispose();
  // }

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
              image: AssetImage('assets/images/Forgetpassword.png'),
              fit: BoxFit.cover),
        ),
      ),
      ChangeNotifierProvider<UserViewModel>(
        create: (context) => userviewModel,
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, _) {
            var status = viewModel.apiResponse.status;
            print('status:${status}');
            if (status == Status.COMPLETED) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  isCheckEmail = true;
                  if (isErro == true) {
                    isCheckCode = true;
                  }
                });
              });
            } else if (status == Status.ERROR) {
              if (isSend == true) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${viewModel.apiResponse.message}')));
                  setState(() {
                    isSend = false;
                  });
                });
              }
            }
            return CustomScrollView(
              anchor: 0.5,
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.maxFinite,
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 40),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 40),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: globalkey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 40, right: 40),
                          child: SizedBox(
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
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                                labelText: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.mainTextColor,
                                ),
                                suffixIcon: isCheckEmail == true
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColors.mainTextColor,
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          if (email.text.isEmpty) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Please Input your Email.')));
                                            });
                                          } else if (!(extString(email.text)
                                              .isValidEmail)) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Invalid Format Email!')));
                                            });
                                          } else {
                                            await viewModel
                                                .sendEmails(email.text);
                                            isSend = true;
                                          }
                                        },
                                        icon: const Icon(Icons.send_outlined),
                                        color: AppColors.mainTextColor),
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
                      isCheckEmail == true
                          ? Form(
                              key: globakey_one,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 40, right: 40),
                                child: SizedBox(
                                  child: TextFormField(
                                    validator: (code) {
                                      if (code!.isEmpty) {
                                        return 'Please enter Verify code ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      if (globakey_one.currentState!
                                          .validate()) {
                                        globakey_one.currentState!.save();
                                      }
                                    },
                                    onFieldSubmitted: (userInput) {
                                      if (globakey_one.currentState!
                                          .validate()) {
                                        globakey_one.currentState!.save();
                                      }
                                    },
                                    controller: code,
                                    decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                        color: AppColors.mainTextColor,
                                      ),
                                      labelText: 'Verify code',
                                      prefixIcon: const Icon(
                                        Icons.verified_user_outlined,
                                        color: AppColors.mainTextColor,
                                      ),
                                      suffixIcon: isCheckCode == true
                                          ? const Icon(Icons.done)
                                          : IconButton(
                                              onPressed: () async {
                                                await viewModel
                                                    .sendCode(code.text);
                                                isErro = true;
                                                isSend = true;
                                              },
                                              icon: const Icon(
                                                  Icons.send_outlined),
                                              color: AppColors.mainTextColor,
                                            ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.mainTextColor),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                              ),
                            )
                          : const Text(""),
                      const SizedBox(
                        height: 20,
                      ),
                      isCheckCode == true
                          ? InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ResetPasswordPage(
                                              code: code.text,
                                            )),
                                    (route) => false);
                              },
                              child: ResponsiveButton(
                                radius: 50,
                                width: 352,
                                heigh: 63,
                                text: 'Submit',
                                textsize: 24,
                              ),
                            )
                          : const Text(''),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      Positioned(
        top: 50,
        left: 10,
        child: IconButton(
          onPressed: () {
            print('Go to Login');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const LoginPage();
            }));
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.mainTextColor,
        ),
      ),
    ])));
  }
}
