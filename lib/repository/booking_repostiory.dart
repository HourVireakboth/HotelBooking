import 'package:hotel_booking_app/model/response/booking_response.dart';
import 'package:hotel_booking_app/model/response/cancelbooking_response.dart';

import '../data/network/network_api_service.dart';
import '../res/app_url.dart';

class BookingRepostiory {
  final _apiService = NetworkApiService();

  Future<BookingResponseModel> getAllBooking(token) async {
    try {
      dynamic response = await _apiService.getBookingApi(AppUrl.getBookingOrder,token);
      print(response);
      return response = BookingResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  Future<CancelBookingResponseModel> getCancelBooking(orderID) async {
    try {
      dynamic response = await _apiService.postCancelBooking(orderID);
      print(response);
      return response = CancelBookingResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  

}