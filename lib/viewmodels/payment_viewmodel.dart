import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/model/response/payment_repsonse.dart';
import 'package:hotel_booking_app/repository/payment_repostiory.dart';
import '../data/response/api_repsonse.dart';

class PaymentViewModel extends ChangeNotifier {
  final _bookingRepo = PaymentRepostiory();

  // var apiResponse = ApiReponse();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<PaymentResponseModel> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<PaymentResponseModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> bookingRoom(userid, roomid, checkin, checkout) async {
    await _bookingRepo
        .bookingRoom(userid, roomid, checkin, checkout)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }
}
