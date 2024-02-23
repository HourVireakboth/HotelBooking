import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/viewmodels/room_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../misc/colors.dart';
import '../../../viewmodels/user_viewmodel.dart';
import '../search.dart';
import 'widgets/room_card.dart';

class CategoryScreenPage extends StatefulWidget {
  const CategoryScreenPage({super.key});

  @override
  State<CategoryScreenPage> createState() => _CategoryScreenPageState();
}

class _CategoryScreenPageState extends State<CategoryScreenPage> {
  var email;
  var password;
  var userID;
  var roomviewModel = RoomViewModel();
  var userviewModel = UserViewModel();
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var emails = prefs.getString('email');
    var passwords = prefs.getString('password');
    print('email:$emails');
    print('pw:$passwords');
    setState(() {
      email = emails;
      password = passwords;
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() {
      userviewModel = UserViewModel();
      getDataUser(email, password);
    });
    roomviewModel.getRoomAll();
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
          GestureDetector(
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
                                builder: (context) => SearchScreen(userID: userID,)));
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              "ROOMS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainTextColor),
            ),
          ),
          SingleChildScrollView(
            child: ChangeNotifierProvider<RoomViewModel>(
              create: (context) => roomviewModel,
              child: Consumer<RoomViewModel>(
                builder: (context, viewModel, _) {
                  var status = viewModel.apiResponse.status;
                  print("status : $status");
                  var room = viewModel.apiResponse.data?.data;
                  switch (status) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.COMPLETED:
                      return SizedBox(
                        height: size.height * 0.75,
                        child: ListView.builder(
                          itemCount: room!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return RoomCardCategory(
                              room: room[index],
                              userID: userID,
                            );
                          }),
                        ),
                      );
                    case Status.ERROR:
                      return const Center(
                        child: Text('Error'),
                      );
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  void getDataUser(email, password) async {
    print('email:$email');
    print('password$password');
    await userviewModel.postUser(email.toString(), password.toString());
    userID = int.parse("${userviewModel.apiResponse.data!.user?.id}");
    print('User ID:$userID');
    print('status: ${userviewModel.apiResponse.status}');
    print('error: ${userviewModel.apiResponse.message}');

    setState(() {});
  }
}
