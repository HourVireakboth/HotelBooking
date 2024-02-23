import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/model/room.dart';
import 'package:hotel_booking_app/model/room_under100.dart';
import 'package:hotel_booking_app/viewmodels/favorite_viewModel.dart';
import 'package:hotel_booking_app/views/pages/home/room_details.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardRoom extends StatefulWidget {
  CardRoom(
      {super.key,
      this.room,
      this.roomunder100,
      this.isCheckunder100,
      this.userId,
      this.token});
  RoomData? room;
  RoomUnder100Data? roomunder100;
  var userId;
  var isCheckunder100;
  var token;
  @override
  State<CardRoom> createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {
  var isfavorite = false;
  var favoriteid;
  var ischeck;
  var favoriteViewModel = FavoriteViewModel();
  @override
  void initState() {
    // TODO: implement initState
    favoriteViewModel = FavoriteViewModel();
    favoriteViewModel.getfavoriteRoom(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoomDetails(
                      room: widget.room,
                      roomunder100: widget.roomunder100,
                      isCheckunder100: widget.isCheckunder100,
                      userId: widget.userId,
                    )));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: AppColors.mainTextColor,
        ),
        width: 200,
        height: 250,
        margin: const EdgeInsets.all(10),
        //padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(children: [
              Container(
                height: size.height * 0.18,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    image: DecorationImage(
                        image: widget.isCheckunder100 == true
                            ? NetworkImage(
                                'http://127.0.0.1:8000/rooms/${widget.roomunder100?.roomImage![0].image}')
                            : NetworkImage(
                                'http://127.0.0.1:8000/rooms/${widget.room?.roomImage![0].image}'),
                        fit: BoxFit.cover)),
                // child: Image.network('https://hips.hearstapps.com/hmg-prod/images/ghk010121homefeature-008-1671137680.png?resize=1200:*'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 19, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isCheckunder100 == true
                        ? Text(
                            '${widget.roomunder100?.name}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        : Text(
                            '${widget.room?.name}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                    const Text('Room',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 14),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: widget.isCheckunder100 == true
                        ? Text('\$${widget.roomunder100!.price} Per Night',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                        : Text('\$${widget.room!.price} Per Night',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                    right: 19,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Text('(5.0)',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  )),
            ]),
            Positioned(
                right: 10,
                child: ChangeNotifierProvider<FavoriteViewModel>(
                  create: (context) => favoriteViewModel,
                  child: Consumer<FavoriteViewModel>(
                    builder: (context, viewModel, _) {
                      var roomid;
                      if (widget.isCheckunder100 == true) {
                        roomid = widget.roomunder100!.id;
                      } else {
                        roomid = widget.room!.id;
                      }
                      print("room id :$roomid");
                      viewModel.apiResponse.data?.data?.forEach((element) {
                        print("element.roomId = ${element.roomId![0].id}");
                        if (element.roomId![0].id == roomid) {
                          favoriteid = element.id;
                          isfavorite = true;
                        }
                      });
                      print('favorite = $favoriteid');
                      return isfavorite == true
                          ? GestureDetector(
                              onTap: () async {
                                await viewModel.deletefavoriteRoom(favoriteid);
                                isfavorite = false;
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 40,
                                color: AppColors.mainTextColor,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await viewModel.postfavoriteRoom(
                                    roomid, widget.userId);
                                viewModel.apiResponse.data?.data?.clear();
                                await viewModel.getfavoriteRoom(widget.token);
                                isfavorite = true;
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 40,
                                color: AppColors.buttonBackground,
                              ),
                            );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
