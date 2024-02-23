import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/viewmodels/payment_viewmodel.dart';
import 'package:hotel_booking_app/views/pages/thankyou.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../misc/colors.dart';
import '../../../widgets/resoponsive_button.dart';

// ignore: must_be_immutable
class SelectDateScreen extends StatefulWidget {
  SelectDateScreen({super.key, this.userID, this.roomID, this.roomPrice});
  int? userID;
  int? roomID;
  var roomPrice;
  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  Map<String, dynamic>? bookingbody;
  Map<String, dynamic>? paymentIntent;
  DateTime? endDate;
  DateTime? startDate;
  int? days_between;
  var totalamount;
  var isCheckTotal;
  var startdate = TextEditingController();
  var enddate = TextEditingController();
  var countday = TextEditingController();
  var paymentViemModel = PaymentViewModel();
  @override
  void initState() {
    // TODO: implement initState
    print("userID = ${widget.userID}");
    print("roomID = ${widget.roomID}");
    print("roomPrice = ${widget.roomPrice}");
    paymentViemModel = PaymentViewModel();
    super.initState();
  }

  DateRangePickerController dateRangePickerController =
      DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentViewModel>(
      create: (context) => paymentViemModel,
      child: Consumer<PaymentViewModel>(
        builder: (context, viewModel, _) {
          var status = viewModel.apiResponse.status;
          if (status == Status.COMPLETED) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ThankYouScreen()));
            });
          }
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.buttonBackground,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: AppColors.buttonBackground,
                centerTitle: true,
                title: const Text(
                  'Select Date',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainTextColor),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 248,
                          width: 315,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.mainTextColor),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                            color: AppColors.buttonBackground,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffDDDDDD),
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                                offset: Offset(0.0, 0.0),
                              )
                            ],
                          ),
                          child: SfDateRangePicker(
                            view: DateRangePickerView.month,
                            selectionMode: DateRangePickerSelectionMode.range,
                            //onSelectionChanged: _onSelectionChanged,
                            controller: dateRangePickerController,
                            showActionButtons: true,
                            onSubmit: (value) {
                              setState(() {
                                dateRangePickerController.selectedRange =
                                    value as PickerDateRange?;
                                print(dateRangePickerController
                                    .selectedRange?.startDate);
                                startDate = dateRangePickerController
                                    .selectedRange?.startDate;
                                String startDateformatted =
                                    DateFormat('yyyy-MM-dd')
                                        .format(startDate as DateTime);
                                startdate.text = startDateformatted;
                                print(dateRangePickerController
                                    .selectedRange?.endDate);
                                endDate = dateRangePickerController
                                    .selectedRange?.endDate;
                                String endDateformatted =
                                    DateFormat('yyyy-MM-dd')
                                        .format(endDate as DateTime);
                                enddate.text = endDateformatted;
                                days_between =
                                    endDate!.difference(startDate!).inDays;
                                countday.text = days_between.toString();
                                setState(() {
                                  totalamount =
                                      days_between! * widget.roomPrice;
                                  isCheckTotal = true;
                                });
                              });
                            },
                            onCancel: () {
                              setState(() {
                                dateRangePickerController.selectedRange = null;
                                startdate.clear();
                                enddate.clear();
                                countday.clear();
                                isCheckTotal = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 50, top: 50, right: 50),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Check in',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                              Text(
                                'Check out',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 45, right: 45, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 135,
                                height: 50,
                                child: TextField(
                                  style: const TextStyle(fontSize: 10),
                                  readOnly: true,
                                  controller: startdate,
                                  decoration: const InputDecoration(
                                    hintText: 'Start Date',
                                    labelStyle: TextStyle(
                                      color: AppColors.mainTextColor,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: AppColors.mainTextColor,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt_rounded,
                                color: AppColors.textgrey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 135,
                                height: 50,
                                child: TextField(
                                  style: const TextStyle(fontSize: 10),
                                  readOnly: true,
                                  controller: enddate,
                                  decoration: const InputDecoration(
                                    hintText: 'End Date',
                                    labelStyle: TextStyle(
                                      color: AppColors.mainTextColor,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: AppColors.mainTextColor,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50, top: 30),
                          child: const Text(
                            'Number of Days',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainTextColor),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 45, right: 45, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 330,
                                child: TextField(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                  controller: countday,
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    labelStyle: const TextStyle(
                                      color: AppColors.mainTextColor,
                                    ),
                                    prefixIcon: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 18, top: 18, left: 22),
                                        child: const Text(
                                          'Count of Days:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.mainTextColor),
                                        )),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50, top: 30),
                          child: const Text(
                            'Total Amount ',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainTextColor),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 55, top: 20, right: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Booking Price:',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              ),
                              isCheckTotal == true
                                  ? Text(
                                      '\$ $totalamount',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.mainTextColor),
                                    )
                                  : const Text(
                                      '\$ 0',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.mainTextColor),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 50, top: 80, right: 50),
                          child: isCheckTotal == true
                              ? GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            decoration: const BoxDecoration(
                                                color:
                                                    AppColors.buttonBackground,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                top: 25, left: 25, right: 25),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  'Choose way to pay',
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors
                                                          .mainTextColor),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 20,
                                                  ),
                                                  height: 74,
                                                  width: 376,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xffDDDDDD),
                                                        blurRadius: 6.0,
                                                        spreadRadius: 2.0,
                                                        offset:
                                                            Offset(0.0, 0.0),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 10,
                                                              bottom: 10),
                                                      width: 76,
                                                      height: 49,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/aba.jpg'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 33,
                                                            top: 18,
                                                            bottom: 20),
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'ABA PAY',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .mainTextColor),
                                                            ),
                                                            Text(
                                                              'Tab to pay with ABA Moblie',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .textgrey),
                                                            ),
                                                          ],
                                                        ))
                                                  ]),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    print('Go to Credit-Card');
                                                    Navigator.pop(context);
                                                    await initPaymentSheet(
                                                        "${totalamount * 100}");
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 20,
                                                    ),
                                                    height: 74,
                                                    width: 376,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xffDDDDDD),
                                                          blurRadius: 6.0,
                                                          spreadRadius: 2.0,
                                                          offset:
                                                              Offset(0.0, 0.0),
                                                        )
                                                      ],
                                                    ),
                                                    child: Row(children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 20,
                                                            top: 10,
                                                            bottom: 10),
                                                        width: 76,
                                                        height: 49,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: const DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/card.png'),
                                                                fit: BoxFit
                                                                    .contain)),
                                                      ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 33,
                                                                  top: 18,
                                                                  bottom: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Credit/Debit Card',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: AppColors
                                                                        .mainTextColor),
                                                              ),
                                                              Container(
                                                                width: 70,
                                                                height: 14,
                                                                decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/images/card3.png'),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              )
                                                            ],
                                                          ))
                                                    ]),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 20,
                                                  ),
                                                  height: 74,
                                                  width: 376,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xffDDDDDD),
                                                        blurRadius: 6.0,
                                                        spreadRadius: 2.0,
                                                        offset:
                                                            Offset(0.0, 0.0),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 10,
                                                              bottom: 10),
                                                      width: 76,
                                                      height: 49,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/khqr.jpg'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 33,
                                                            top: 18,
                                                            bottom: 20),
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'KHQR',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .mainTextColor),
                                                            ),
                                                            Text(
                                                              'Scan to pay with member bank app',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .textgrey),
                                                            ),
                                                          ],
                                                        ))
                                                  ]),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 20,
                                                  ),
                                                  height: 74,
                                                  width: 376,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xffDDDDDD),
                                                        blurRadius: 6.0,
                                                        spreadRadius: 2.0,
                                                        offset:
                                                            Offset(0.0, 0.0),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 10,
                                                              bottom: 10),
                                                      width: 76,
                                                      height: 49,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/alipay.jpg'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 33,
                                                            top: 18,
                                                            bottom: 20),
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Alipay',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .mainTextColor),
                                                            ),
                                                            Text(
                                                              'Scan to pay with alipay',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .textgrey),
                                                            ),
                                                          ],
                                                        ))
                                                  ]),
                                                ),
                                              ],
                                            ));
                                      },
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                    );
                                  },
                                  child: ResponsiveButton(
                                    heigh: 63,
                                    width: 352,
                                    text: 'Continue',
                                    radius: 50,
                                    textsize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : ResponsiveButton(
                                  heigh: 63,
                                  width: 352,
                                  text: 'Continue',
                                  color: AppColors.textgrey,
                                  radius: 50,
                                  textsize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

Future<void> initPaymentSheet(String amount) async {
    try {
      // 1. create payment intent on the server
      paymentIntent = await createPaymentIntent(amount);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent?['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Vireakboth',
            // googlePay: gpay
          ))
          .then((value) {});
      displayPaymentSheet();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet().then((value) {
      print('Payment successfully');

      paymentViemModel.bookingRoom(
          widget.userID, widget.roomID, startDate, endDate);
    });
  }

  createPaymentIntent(amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': 'USD',
      };
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NL1fxFvNJihYHXJaqy7V6Iu8TviNi2v9ZU5vQA95sXwvvfxcXEPE4mUzaUetTJdBT3GvPwpVgX52eVrNjD9Pv3v00oha5ptg1',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}
