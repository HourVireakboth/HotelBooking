import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/helper/fromvalidate.dart';
import 'package:hotel_booking_app/model/response/userloginresponse.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/pages/mainpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../misc/colors.dart';
import '../../../widgets/resoponsive_button.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  EditProfile({super.key, this.users, this.token});
  User? users;
  String? token;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PickedFile? pickedfile;
  var uploading = false;
  var isImagePicked = false;
  var imagefile;
  var imageid;
  var name = TextEditingController();
  var pincode = TextEditingController();
  var gender = TextEditingController();
  var phone = TextEditingController();
  DateTime? dob;
  var address = TextEditingController();
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var globalkey_three = GlobalKey<FormState>();
  var globalkey_four = GlobalKey<FormState>();
  var globalkey_five = GlobalKey<FormState>();
  var globalkey_six = GlobalKey<FormState>();
  var globalkey_seven = GlobalKey<FormState>();
  var listrate = ['Male', 'Female', 'Other'];
  var currentgender;
  var userviewModel;

  @override
  void initState() {
    super.initState();
    print('token:${widget.token}');
    userviewModel = UserViewModel();
    name.text = widget.users!.name.toString();
    currentgender =
        widget.users!.gender == null ? "" : widget.users!.gender.toString();
    phone.text =
        widget.users?.phonenum == null ? "" : widget.users!.phonenum.toString();
    pincode.text =
        widget.users?.pincode == null ? "" : widget.users!.pincode.toString();
    dob = DateTime.tryParse(widget.users!.dob == null
        ? DateTime.now().toString()
        : DateFormat("yyyy-MM-dd").format(widget.users!.dob as DateTime));
    address.text =
        widget.users?.address == null ? "" : widget.users!.address.toString();
    imageid = widget.users!.profile.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: AppColors.buttonBackground,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<UserViewModel>(
            create: (context) => userviewModel,
            child: Consumer<UserViewModel>(
              builder: (context, viewModel, _) {
                var status = viewModel.apiResponse.status;
                print('status: $status');
                if (status == Status.COMPLETED) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Update Information Successful')));
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MainPageScreen()),
                        (route) => false);
                  });
                } else if (status == Status.ERROR) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${viewModel.apiResponse.message}')));
                  });
                }
                return Container(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 233,
                              width: 233,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainTextColor,
                                  image: isImagePicked == false
                                      ? DecorationImage(
                                          image: imageid != null
                                              ? NetworkImage(imageid ==
                                                      'http://127.0.0.1:8000/Users/Boy.png'
                                                  ? imageid
                                                  : 'http://127.0.0.1:8000/profile/$imageid')
                                              : const NetworkImage(
                                                  'http://127.0.0.1:8000/Users/Boy.png'),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: FileImage(imagefile),
                                          fit: BoxFit.cover)),
                            ),
                            Positioned(
                              top: 180,
                              right: 30,
                              child: GestureDetector(
                                onTap: () {
                                  print('Edit Profile');
                                  setState(() {
                                    getImageFromSource();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.mainTextColor),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                         Text('${widget.users?.name}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainTextColor)),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(children: [
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
                                onChanged: (userInput) {
                                  if (globalkey.currentState!.validate()) {
                                    globalkey.currentState!.save();
                                  }
                                },
                                controller: name,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'User Name',
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
                            Container(
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.mainTextColor),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isDense: true,
                                  value: currentgender,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      currentgender = value;
                                    });
                                  },
                                  items: listrate.map((rate) {
                                    return DropdownMenuItem(
                                      value: rate,
                                      alignment: Alignment.center,
                                      child: Text(rate.toString()),
                                    );
                                  }).toList(),
                                  hint: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: AppColors.mainTextColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  elevation: 1,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: AppColors.mainTextColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: globalkey_three,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                validator: (username) {
                                  if (username!.isEmpty) {
                                    return 'Please enter Phone';
                                  } else {
                                    if (extString(username).isValidPhone) {
                                      return null;
                                    } else {
                                      return 'Invaild Format Phone';
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
                                controller: phone,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Phone',
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
                              key: globalkey_four,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (pincode) {
                                  if (pincode!.isEmpty) {
                                    return 'Please enter pincode';
                                  } else {
                                    if (pincode.length > 8) {
                                      return 'pincode must be 8 number up ';
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                onFieldSubmitted: (userInput) {
                                  if (globalkey_four.currentState!.validate()) {
                                    globalkey_four.currentState!.save();
                                  }
                                },
                                controller: pincode,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Pincode',
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
                            DateTimeFormField(
                              initialValue: dob,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: AppColors.mainTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.mainTextColor),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.event_note,
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Date of birth',
                                  labelStyle: TextStyle(
                                      color: AppColors.mainTextColor)),
                              dateFormat: DateFormat("yyyy-MM-dd"),
                              mode: DateTimeFieldPickerMode.date,
                              initialDate: dob,
                              autovalidateMode: AutovalidateMode.always,
                              // validator: (e) => (e?.day ?? 0) == 1
                              //     ? 'Please not the first day'
                              //     : null,
                              onDateSelected: (DateTime value) {
                                setState(() {
                                  dob = value;
                                  print('dob:$dob');
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: globalkey_six,
                              child: TextFormField(
                                validator: (address) {
                                  if (address!.isEmpty) {
                                    return 'Please enter Address';
                                  } else {
                                    if (address.length > 10) {
                                      return null;
                                    } else {
                                      return 'Address must be 10 letter up ';
                                    }
                                  }
                                },
                                onFieldSubmitted: (userInput) {
                                  if (globalkey_six.currentState!.validate()) {
                                    globalkey_six.currentState!.save();
                                  }
                                },
                                onChanged: (userInput) {
                                  if (globalkey_six.currentState!.validate()) {
                                    globalkey_six.currentState!.save();
                                  }
                                },
                                controller: address,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: AppColors.mainTextColor,
                                  ),
                                  labelText: 'Address',
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
                            GestureDetector(
                              onTap: () async {
                                if (name.text.isEmpty ||
                                    phone.text.isEmpty ||
                                    pincode.text.isEmpty ||
                                    address.text.isEmpty) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Missing some field Please check and Input all Information.')));
                                  });
                                } else if (!(extString(name.text)
                                    .isValidName)) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Invaild Name Format')));
                                  });
                                } else if (!(extString(phone.text)
                                    .isValidPhone)) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Phone number must be 9 up')));
                                  });
                                } else if (!(pincode.text.length >= 5 &&
                                    pincode.text.length <= 9)) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Pincode must be 5 number up!')));
                                  });
                                } else if (!(dob!.year < DateTime.now().year)) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Date of Birth must be small then Date Time now')));
                                  });
                                } else if (!(address.text.length >= 10)) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Adress must be 10 letter up !')));
                                  });
                                } else {
                                  await viewModel.updateUser(
                                      widget.token.toString(),
                                      name.text.toString(),
                                      address.text.toString(),
                                      phone.text.toString(),
                                      pincode.text.toString(),
                                      dob,
                                      currentgender.toString());
                                  if (isImagePicked == true) {
                                    viewModel.updateUserProfile(
                                        widget.token, pickedfile!.path);
                                  }
                                }
                              },
                              child: ResponsiveButton(
                                radius: 50,
                                width: 365,
                                heigh: 63,
                                text: 'Save',
                                textsize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  dynamic getImageFromSource() async {
    pickedfile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1900);

    if (pickedfile != null) {
      setState(() {
        isImagePicked = true;
        imagefile = File(pickedfile!.path);
        uploading = true;
      });
    }
  }
}
