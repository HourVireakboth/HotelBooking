import 'package:hotel_booking_app/model/request/payment_request.dart';
import 'package:hotel_booking_app/model/response/payment_repsonse.dart';
import 'package:hotel_booking_app/res/app_url.dart';

import '../data/network/network_api_service.dart';

class PaymentRepostiory {
  final _apiService = NetworkApiService();

  Future<dynamic> bookingRoom(userid, roomid, checkin, checkout) async {
    try {
      var bookingModel = PaymentRequestModel(
          userId: userid, roomId: roomid, checkIn: checkin, checkOut: checkout);
      dynamic response = await _apiService.postBookingOrder(
          AppUrl.BookingOrder, bookingModel.toJson());
      print('Response : $response');
      print(PaymentResponseModel.fromJson(response));
      return response = PaymentResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
