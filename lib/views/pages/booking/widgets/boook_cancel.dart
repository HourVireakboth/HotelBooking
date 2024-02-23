import 'package:flutter/material.dart';
import 'package:hotel_booking_app/model/response/booking_response.dart';
import 'package:intl/intl.dart';

import '../../../../misc/colors.dart';
import '../../../../widgets/resoponsive_button.dart';

class BookingCancel extends StatefulWidget {
  const BookingCancel({super.key,this.roombooking});
 final BookingData? roombooking;
  @override
  State<BookingCancel> createState() => _BookingCancelState();
}

class _BookingCancelState extends State<BookingCancel> {
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
                  height: 202,
                  width: 193,
                  decoration:  BoxDecoration(
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
                        style: const  TextStyle(
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
                        style:const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(
                        'Total:\$ ${widget.roombooking?.amount}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ResponsiveButton(
                        width: 155,
                        heigh: 30,
                        text: 'Refund in process!',
                        radius: 25,
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}