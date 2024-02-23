import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/model/response/booking_response.dart';
import 'package:hotel_booking_app/model/response/cancelbooking_response.dart';
import 'package:hotel_booking_app/repository/booking_repostiory.dart';

import '../data/response/api_repsonse.dart';

class BookingViewModel extends ChangeNotifier {
  final _bookingRepo = BookingRepostiory();

  // var apiResponse = ApiReponse();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<BookingResponseModel> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<BookingResponseModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  ApiReponse<CancelBookingResponseModel> CancelapiResponse = ApiReponse();
  setCancelApiResponse(ApiReponse<CancelBookingResponseModel> response) {
    CancelapiResponse = response;
    notifyListeners();
  }

  Future<dynamic> getBookingAll(token) async {
    await _bookingRepo
        .getAllBooking(token)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

  Future<dynamic> getCancelBooking(orderID) async {
    await _bookingRepo
        .getCancelBooking(orderID)
        .then((response) =>setCancelApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setCancelApiResponse(ApiReponse.error(error.toString())));
    print(CancelapiResponse);
  }

}