import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/model/response/searchrespornse.dart';
import 'package:hotel_booking_app/views/pages/home/room_details.dart';
import 'package:hotel_booking_app/views/pages/home/select_date.dart';

import '../../../misc/colors.dart';
import '../../../widgets/resoponsive_button.dart';

// ignore: must_be_immutable
class RoomSearchCard extends StatefulWidget {
  RoomSearchCard({super.key, this.rooms, this.userID});
  SearchResponseData? rooms;
  int? userID;
  @override
  State<RoomSearchCard> createState() => _RoomSearchCardState();
}

class _RoomSearchCardState extends State<RoomSearchCard> {
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
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                        image: NetworkImage(
                            'http://127.0.0.1:8000/rooms/${widget.rooms?.roomImage?[0].image}'),
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
            Text('${widget.rooms?.name}',
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
            Text('\$ ${widget.rooms?.price} per month',
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
                              userID: int.parse('${widget.userID}') ,
                              roomID:  int.parse('${widget.rooms?.id}') ,
                              roomPrice: widget.rooms?.price,
                            )));
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
                              searchData: widget.rooms,
                              isSearch: true,
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
