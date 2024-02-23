import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/viewmodels/booking_viewmodel.dart';
import 'package:hotel_booking_app/viewmodels/user_viewmodel.dart';
import 'package:hotel_booking_app/views/pages/booking/widgets/boook_cancel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../misc/colors.dart';
import '../search.dart';
import 'widgets/book_Review.dart';
import 'widgets/booking_new.dart';
import 'widgets/booking_past.dart';

class BookingScreenPage extends StatefulWidget {
  const BookingScreenPage({super.key});

  @override
  State<BookingScreenPage> createState() => _BookingScreenPageState();
}

class _BookingScreenPageState extends State<BookingScreenPage>
    with TickerProviderStateMixin {
  var _tabcontroller;
  var bookingviewModel = BookingViewModel();
  var userviewModel = UserViewModel();
  var email;
  var password;
  var token;
  var userID;
  var data = [];
  var dataset = [];
  var datarevser = [];
  var data2 = [];
  var dataset2 = [];
  var datarevser2 = [];
  var data3 = [];
  var dataset3 = [];
  var datarevser3 = [];
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var emails = prefs.getString('email');
    var passwords = prefs.getString('password');
    var tokens = prefs.getString('token');
    print('email:$emails');
    print('pw:$passwords');
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
      bookingviewModel.apiResponse.status;
      bookingviewModel.getBookingAll(token);
    });
    _tabcontroller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 80,
        ),
        child: Column(children: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(width: 2, color: AppColors.mainTextColor)),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Row(children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.search),
                SizedBox(
                  width: 15,
                ),
                Text('Search')
              ]),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            userID: int.parse('$userID'),
                          )));
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              "BOOKING",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainTextColor),
            ),
          ),
          DefaultTabController(
            length: 4,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabcontroller,
                    isScrollable: true,
                    indicatorColor: AppColors.mainTextColor,
                    unselectedLabelColor: const Color.fromARGB(255, 85, 85, 85),
                    labelColor: AppColors.mainTextColor,
                    indicator: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        //color: Colors.grey[300],
                        ),
                    splashBorderRadius: BorderRadius.circular(10),
                    tabs: [
                      const Tab(
                        text: "New",
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: const Tab(
                          text: "Past",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: const Tab(
                          text: "Cancel",
                        ),
                      ),
                      const Tab(
                        text: "Review",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    width: double.maxFinite,
                    height: size.height * 0.68,
                    child: ChangeNotifierProvider<BookingViewModel>(
                      create: (context) => bookingviewModel,
                      child: Consumer<BookingViewModel>(
                        builder: (context, viewModel, _) {
                          var status = viewModel.apiResponse.status;
                          //var roombooking = viewModel.apiResponse.data?.data;
                          viewModel.apiResponse.data?.data?.forEach((element) {
                            if (element.bookingStatus == "Booked") {
                              int numberdate = element.checkIn!
                                  .difference(element.checkOut!)
                                  .inDays;
                              print("numberdata : $numberdate");
                              int datetimenow = element.checkIn!
                                  .difference(DateTime.now())
                                  .inDays;
                              print("datatimenow : $datetimenow");
                              if (numberdate <= datetimenow) {
                                data.add(element);
                              } else if (numberdate > datetimenow) {
                                data3.add(element);
                              }
                            } else if (element.bookingStatus == "cancelled") {
                              data2.add(element);
                            }
                          });
                          if (status == Status.COMPLETED) {
                            dataset = data.toSet().toList();
                            datarevser = dataset.reversed.toList();
                            dataset2 = data2.toSet().toList();
                            datarevser2 = dataset2.reversed.toList();
                            dataset3 = data3.toSet().toList();
                            datarevser3 = dataset3.reversed.toList();
                            return TabBarView(
                                controller: _tabcontroller,
                                children: [
                                  RefreshIndicator(
                                      onRefresh: () async {
                                        setState(() async {
                                          datarevser.clear();
                                          dataset.clear();
                                          data.clear();
                                          await bookingviewModel
                                              .getBookingAll(token);
                                        });
                                      },
                                      child: datarevser.isEmpty
                                          ? const Center(
                                              child: Text(
                                                'No Booking Record',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textgrey),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: datarevser.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: ((context, index) {
                                                return BookingNewCard(
                                                  roombooking:
                                                      datarevser[index],
                                                );
                                              }),
                                            )),
                                  datarevser3.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'No Booking Past Record',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgrey),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: datarevser3.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: ((context, index) {
                                            return BookingPastCard(
                                              roombooking: datarevser3[index],
                                              userId: userID,
                                            );
                                          }),
                                        ),
                                  datarevser2.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'No Cancel Booking Record',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgrey),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: datarevser2.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: ((context, index) {
                                            return BookingCancel(
                                              roombooking: datarevser2[index],
                                            );
                                          }),
                                        ),
                                  ListView.builder(
                                    itemCount: 10,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: ((context, index) {
                                      return const BookingReviewCard();
                                    }),
                                  ),
                                ]);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void getDataUser(email, password) async {
    print('email:$email');
    print('password$password');
    await userviewModel.postUser(email.toString(), password.toString());
    userID = "${userviewModel.apiResponse.data!.user!.id}";
    print('userID :$userID');
    print('status: ${userviewModel.apiResponse.status}');
    print('error: ${userviewModel.apiResponse.message}');
    setState(() {});
  }
}
