import 'package:flutter/material.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/Login_page.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../misc/colors.dart';
import '../widgets/resoponsive_button.dart';

// ignore: must_be_immutable
class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({super.key, this.code});
  String? code;
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm = TextEditingController();
  var userviewModel;
  var _isobscured;
  @override
  void initState() {
    // TODO: implement initState
    _isobscured = false;
    super.initState();
    userviewModel = UserViewModel();
    print('code:${widget.code}');
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
              image: AssetImage('assets/images/Forgetpassword.png'),
              fit: BoxFit.cover),
        ),
      ),
      ChangeNotifierProvider<UserViewModel>(
        create: (context) => userviewModel,
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, _) {
            var status = viewModel.apiResponse.status;
            if (status == Status.COMPLETED) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              });
            } else if (status == Status.ERROR) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${viewModel.apiResponse.message}')));
              });
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
                            'Rest Password?',
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'New Password',
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: SizedBox(
                          child: Form(
                            key: globalkey,
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
                                if (globalkey.currentState!.validate()) {
                                  globalkey.currentState!.save();
                                }
                              },
                              onFieldSubmitted: (userInput) {
                                if (globalkey.currentState!.validate()) {
                                  globalkey.currentState!.save();
                                }
                              },
                              obscureText: _isobscured,
                              controller: password,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: AppColors.mainTextColor,
                                ),
                                labelText: 'New Password',
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
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
                                  if (confirm.text == password.text) {
                                    return null;
                                  } else {
                                    return 'Password must be same as above';
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
                              controller: confirm,
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
                          if (password.text.isEmpty && confirm.text.isEmpty) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                      content: Text(
                                          ' Please input Password and  Confirm Password!')));
                            } 
                            );
                          }else if (!(extString(password.text).isValidPassword)){
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                      content: Text(
                                          ' Invaild Format Password!(Password required : capital ,letter , symbol ,number )')));
                            } 
                            );
                          }else if (confirm.text != password.text){
                              WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                      content: Text(
                                          ' ConFirm password  the same password!')));
                            } 
                            );
                          }else{
                              viewModel.sendChangePassword(
                              widget.code, password.text);
                          }
                        },
                        child: ResponsiveButton(
                          radius: 50,
                          width: 352,
                          heigh: 63,
                          text: 'Submit',
                          textsize: 24,
                        ),
                      ),
                    ]),
                  ),
                )
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
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const LoginPage();
              }), (context)=>false);  
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.mainTextColor,
        ),
      ),
    ])));
  }
}
