import 'package:flutter/material.dart';
import 'package:hotel_booking_app/model/response/booking_response.dart';
import 'package:hotel_booking_app/viewmodels/booking_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../misc/colors.dart';
import '../../../../widgets/resoponsive_button.dart';

class BookingNewCard extends StatefulWidget {
  const BookingNewCard({super.key, this.roombooking});
 final BookingData? roombooking;
  @override
  State<BookingNewCard> createState() => _BookingNewCardState();
}

class _BookingNewCardState extends State<BookingNewCard> {
  var bookingviewModel = BookingViewModel();
  @override
  void initState() {
    // TODO: implement initState
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
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  ChangeNotifierProvider<BookingViewModel>(
                                    create: (context) => bookingviewModel,
                                    child: Consumer<BookingViewModel>(
                                      builder: (context, viewModel, child) {
                                        var status = viewModel.CancelapiResponse.status;
                                        if (status == Status.COMPLETED) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar( SnackBar(
                                                    content:Text(
                                                        '${viewModel.CancelapiResponse.data!.message}')));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please refresh page new.')));
                                          });
                                        }
                                        return AlertDialog(
                                          title: const Text(
                                              'Are you sure to Cancel ?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('NO')),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    viewModel.getCancelBooking(
                                                        int.parse(
                                                            "${widget.roombooking!.id}"));
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: viewModel.CancelapiResponse
                                                            .status ==
                                                        Status.LOADING
                                                    ? const CircularProgressIndicator()
                                                    : const Text('Yes')),
                                          ],
                                        );
                                      },
                                    ),
                                  ));
                        },
                        child: ResponsiveButton(
                          width: 140,
                          heigh: 25,
                          text: 'Cancel Booking',
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
