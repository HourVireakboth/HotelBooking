import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/model/response/booking_response.dart';
import 'package:hotel_booking_app/views/pages/home/select_date.dart';
import 'package:intl/intl.dart';
import '../../../../misc/colors.dart';
import '../../../../viewmodels/booking_viewModel.dart';
import '../../../../widgets/resoponsive_button.dart';

class BookingPastCard extends StatefulWidget {
  const BookingPastCard({super.key, this.roombooking, this.userId});
  final BookingData? roombooking;
  final userId;
  @override
  State<BookingPastCard> createState() => _BookingPastCardState();
}

class _BookingPastCardState extends State<BookingPastCard> {
  double rating = 0;
  var bookingviewModel = BookingViewModel();
  @override
  void initState() {
    print('userID : ${widget.userId}');
    bookingviewModel = BookingViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
        padding: const EdgeInsets.all(0),
        child: Container(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 225,
                  width: 180,
                  decoration: BoxDecoration(
                      color: AppColors.mainTextColor,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'http://127.0.0.1:8000/rooms/${widget.roombooking?.roomId?.image}'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  //margin: const EdgeInsets.only(left: 40,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.roombooking?.bookingDetails?[0].roomName}',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$ ${widget.roombooking?.bookingDetails?[0].price} Per Night',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Check in: ${DateFormat('yyyy-MM-dd').format(widget.roombooking?.checkIn as DateTime)}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Check out: ${DateFormat('yyyy-MM-dd').format(widget.roombooking?.checkOut as DateTime)}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Order ID: ${widget.roombooking?.stripePaymentId}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total:\$${widget.roombooking?.amount}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SelectDateScreen(userID:int.parse(widget.userId),
                                  roomID: int.parse('${widget.roombooking?.bookingDetails?[0].id}'),
                                  roomPrice: int.parse("${widget.roombooking?.bookingDetails?[0].price}"),)));
                        },
                        child: ResponsiveButton(
                          width: 140,
                          heigh: 25,
                          text: 'Rebooking',
                          radius: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ResponsiveButton(
                        width: 140,
                        heigh: 25,
                        text: 'Rate & Review',
                        radius: 25,
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}
