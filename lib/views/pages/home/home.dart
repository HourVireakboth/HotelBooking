import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/viewmodels/room_viewmodel.dart';
import 'package:hotel_booking_app/viewmodels/roomunder100_viewmodel.dart';
import 'package:hotel_booking_app/views/pages/profile/favorite.dart';
import 'package:hotel_booking_app/views/pages/profile/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewmodels/user_viewmodel.dart';
import '../search.dart';
import 'widgets/card_room.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with TickerProviderStateMixin {
  var _tabcontroller;
  var isDisposeroom;
  var isDisposeroomunder;
  String? email;
  String? password;
  int? userID;
  int currentPage = 0;
  var token;
  var userviewModel = UserViewModel();
  var roomviewModel = RoomViewModel();
  var roomUnder100viewModel = RoomUnder100ViewModel();
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
    roomUnder100viewModel.getRoomUnder100();
    // TODO: implement initState
    _tabcontroller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return userviewModel.apiResponse.status == Status.COMPLETED
        ? Scaffold(
          backgroundColor: AppColors.buttonBackground,
            appBar: AppBar(
              title: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 7),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.mainTextColor,
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: userviewModel
                                            .apiResponse.data!.user!.profile
                                            .toString() ==
                                        "http://127.0.0.1:8000/Users/Boy.png"
                                    ? NetworkImage(
                                        '${userviewModel.apiResponse.data!.user!.profile}')
                                    : NetworkImage(
                                        'http://127.0.0.1:8000/profile/${userviewModel.apiResponse.data!.user!.profile}'),
                                fit: BoxFit.cover))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        Text(
                          '${userviewModel.apiResponse.data!.user!.name}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainTextColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.notifications_none_outlined,color: AppColors.mainTextColor,size:35,),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()));
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.favorite_outline_sharp ,color: AppColors.mainTextColor,size:35,),
                        onTap: () {
                          print('Go to Favorite');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       FavoriteScreen(token: token,)));
                        },
                      )
                    ],
                  ),
                )
              ],
              centerTitle: true,
              backgroundColor: AppColors.buttonBackground,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Material(
                    //   elevation: 15,
                    //   borderRadius: BorderRadius.circular(30),
                    //   shadowColor: Color(0x55434343),
                    //   child: const TextField(
                    //     textAlign: TextAlign.start,
                    //     textAlignVertical: TextAlignVertical.center,
                    //     decoration: InputDecoration(
                    //       hintText: "Search",
                    //       prefixIcon: Icon(Icons.search, color: Colors.black54,),
                    //       border: InputBorder.none),
                    //   ),
                    // ),
                    GestureDetector(
                      child: Container(
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(
                                width: 2, color: AppColors.mainTextColor)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: size.height * 0.20,
                      child: Swiper(
                        autoplay: true,
                        // autoplayDelay: 1,
                        itemCount: 3,
                        itemBuilder: (ctx, index) {
                          return buildCard(item: items[index]);
                        },
                        pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                                activeColor: Colors.redAccent)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      child: Text(
                        "Choose Room",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(54, 144, 127, 1)),
                      ),
                    ),

                    DefaultTabController(
                      length: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabcontroller,
                              isScrollable: true,
                              indicatorColor: AppColors.mainTextColor,
                              unselectedLabelColor:
                                  const Color.fromARGB(255, 85, 85, 85),
                              labelColor: AppColors.mainTextColor,
                              indicator: const BoxDecoration(
                                  //borderRadius: BorderRadius.circular(20),
                                  //color: Colors.grey[300],
                                  ),
                              splashBorderRadius: BorderRadius.circular(10),
                              tabs: [
                                const Tab(
                                  text: "Recommanded",
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: const Tab(
                                    text: "Popular",
                                  ),
                                ),
                                const Tab(
                                  text: "Under 100\$",
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: const EdgeInsets.all(0),
                                width: double.maxFinite,
                                height: size.height * 0.28,
                                child: ChangeNotifierProvider<RoomViewModel>(
                                  create: (context) => roomviewModel,
                                  child: ChangeNotifierProvider<
                                      RoomUnder100ViewModel>(
                                    create: (context) => roomUnder100viewModel,
                                    child: Consumer2<RoomViewModel,
                                        RoomUnder100ViewModel>(
                                      builder: (context, roomviewModel,
                                          roomunderviewModel, child) {
                                        var status1 =
                                            roomviewModel.apiResponse.status;
                                        var status2 = roomUnder100viewModel
                                            .apiResponse.status;
                                        var room1 = roomviewModel
                                            .apiResponse.data!.data;
                                        var length = roomviewModel
                                            .apiResponse.data!.data.length;
                                        print('room count : ${length}');
                                        var room2 = roomunderviewModel
                                            .apiResponse.data!.data;
                                        if (status1 == Status.COMPLETED &&
                                            status2 == Status.COMPLETED) {
                                          return TabBarView(
                                              controller: _tabcontroller,
                                              children: [
                                                Container(
                                                  child: ListView.builder(
                                                    itemCount: room1.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return CardRoom(
                                                        room: room1[index],
                                                        isCheckunder100: false,
                                                        userId: userID,
                                                        token: token,
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    itemCount: room1.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return CardRoom(
                                                        room: room1[index],
                                                        isCheckunder100: false,
                                                        userId: userID,
                                                        token: token,
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    itemCount: room2.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return CardRoom(
                                                        roomunder100:
                                                            room2[index],
                                                        isCheckunder100: true,
                                                        userId: userID,
                                                        token: token,
                                                      );
                                                    }),
                                                  ),
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
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Our Facilities',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainTextColor),
                                  ),
                                  Text('See all',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.mainTextColor))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/wifi.jpg'))),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Air conditioner.jpg'))),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Smart TV.jpg'))),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/SPA 1.jpg'))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    userID = int.parse("${userviewModel.apiResponse.data?.user?.id}");
    token = "${userviewModel.apiResponse.data?.user?.token}";
    print('User ID:$userID');
    print('status: ${userviewModel.apiResponse.status}');
    print('error: ${userviewModel.apiResponse.message}');

    setState(() {});
  }
}

class CardItem {
  final String urlImg;

  CardItem({required this.urlImg});
}

List<CardItem> items = [
  CardItem(urlImg: 'https://i.insider.com/598336c3b9cd6c1e008b45aa?width=700'),
  CardItem(urlImg: 'https://i.insider.com/598336c3b9cd6c1e008b45aa?width=700'),
  CardItem(urlImg: 'https://i.insider.com/598336c3b9cd6c1e008b45aa?width=700'),
];

Widget buildCard({
  required CardItem item,
}) =>
    Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          item.urlImg,
          fit: BoxFit.cover,
        ),
      ),
    );
