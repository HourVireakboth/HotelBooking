import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/viewmodels/help_viewModel.dart';
import 'package:provider/provider.dart';
import '../../../misc/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var globalkey_three = GlobalKey<FormState>();
  var globalkey_four = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var subject = TextEditingController();
  var message = TextEditingController();
  var helpviewModel = HelpViewModel();
  @override
  void initState() {
    helpviewModel = HelpViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackground,
      appBar: AppBar(
        iconTheme: const  IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: AppColors.buttonBackground,
        title: const Text(
          'Help',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () async {
                  print('send');

                  if (name.text.isEmpty ||
                      email.text.isEmpty ||
                      subject.text.isEmpty ||
                      message.text.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Missing some field Please input all Information')));
                    });
                  } else if (!(extString(name.text).isValidName)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid Name')));
                    });
                  } else if (!(extString(email.text).isValidEmail)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Invalid Format Email!')));
                    });
                  } else if (!(subject.text.length > 5)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Subject must be 5 letter up.')));
                    });
                  } else if (!(message.text.length > 10)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Message must be 10 letter up.')));
                    });
                  } else {
                    await helpviewModel.userHelp(
                        name.text.toString(),
                        email.text.toString(),
                        subject.text.toString(),
                        message.text.toString());
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: AppColors.mainTextColor,
                  size: 30,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<HelpViewModel>(
          create: (context) => helpviewModel,
          child: Consumer<HelpViewModel>(
            builder: (context, viewModel, _) {
              var status = viewModel.apiResponse.status;
              if (status == Status.COMPLETED) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Your Message have been send Succesfully')));
                  clear();
                });
              }
              return Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Send a Message',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: globalkey_two,
                        child: TextFormField(
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Please enter Email';
                            } else {
                              if (extString(email).isValidEmail) {
                                return null;
                              } else {
                                return 'Invaild Format Email';
                              }
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
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: globalkey_three,
                        child: TextFormField(
                          validator: (subject) {
                            if (subject!.isEmpty) {
                              return 'Please enter subject';
                            } else if (subject.length >= 5) {
                              return 'subject much 5 letter up';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (userInput) {
                            if (globalkey_three.currentState!.validate()) {
                              globalkey_three.currentState!.save();
                            }
                          },
                          controller: subject,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: AppColors.mainTextColor,
                            ),
                            labelText: 'Subject',
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
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: globalkey_four,
                        child: TextFormField(
                          minLines: 8,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          validator: (message) {
                            if (message!.isEmpty) {
                              return 'Please enter message';
                            } else if (message.length >= 10) {
                              return 'message 10 letter up';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (userInput) {
                            if (globalkey_four.currentState!.validate()) {
                              globalkey_four.currentState!.save();
                            }
                          },
                          controller: message,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: AppColors.mainTextColor,
                            ),
                            hintStyle:
                                TextStyle(color: AppColors.mainTextColor),
                            hintText: 'Message',
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Send a Message',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.location_on),
                          Text('PhnomPenh,Russey Keo St 99')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Call us',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 10,
                          ),
                          Text('096 7383 551')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 10,
                          ),
                          Text('011 6383 81')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(
                            width: 10,
                          ),
                          Text('sahotel@gmail.com')
                        ],
                      ),
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
void clear() {
    name.clear();
    email.clear();
    subject.clear();
    message.clear();
  }
}
