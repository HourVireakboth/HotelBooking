import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/model/room.dart';
import 'package:hotel_booking_app/views/pages/home/select_date.dart';

import '../../../../misc/colors.dart';
import '../../../../widgets/resoponsive_button.dart';
import '../../home/room_details.dart';

// ignore: must_be_immutable
class RoomCardCategory extends StatefulWidget {
  RoomCardCategory({super.key, this.room,this.userID});
  RoomData? room;
  var userID;
  @override
  State<RoomCardCategory> createState() => _RoomCardCategoryState();
}

class _RoomCardCategoryState extends State<RoomCardCategory> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 162,
              width: 172,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: AppColors.mainTextColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                      child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      width: 25,
                      height: 7,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 25,
                      height: 7,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 25,
                      height: 7,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 25,
                      height: 7,
                      color: Colors.white,
                    ),
                  ]),
            ),
            Positioned(
              left: 20,
              bottom: 10,
              child: Container(
                height: 162,
                width: 172,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                        image: NetworkImage(
                            'http://127.0.0.1:8000/rooms/${widget.room?.roomImage?[0].image}'),
                        fit: BoxFit.cover),
                    color: AppColors.mainTextColor),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 35,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.room?.name}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainTextColor)),
            const SizedBox(
              height: 5,
            ),
            const Text('Room',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textgrey)),
            const SizedBox(
              height: 5,
            ),
            Text('\$ ${widget.room?.price} per month',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textgrey)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                RatingBar.builder(
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    updateOnDrag: true,
                    initialRating: 3,
                    itemSize: 15,
                    minRating: 1,
                    maxRating: 5,
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    }),
                const SizedBox(
                  width: 5,
                ),
                const Text('(490 Reviews)'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => SelectDateScreen(
                          userID: widget.userID,
                          roomID:  widget.room?.id,
                          roomPrice:  widget.room?.price,
                        ) ));
              },
              child: ResponsiveButton(
                width: 170,
                heigh: 25,
                text: 'Book Now',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => RoomDetails(
                              room: widget.room,
                              isCheckunder100: false,
                              userId: widget.userID,
                            )));
              },
              child: ResponsiveButton(
                width: 170,
                heigh: 25,
                text: 'More Details',
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
