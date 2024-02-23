import 'package:hotel_booking_app/model/room.dart';

import 'package:hotel_booking_app/res/app_url.dart';

import '../data/network/network_api_service.dart';

class RoomRepostiory {
  final _apiService = NetworkApiService();
  Future<RoomModel> getAllRoom() async {
    try {
      dynamic response = await _apiService.getRoomApi(AppUrl.getRoom);
      print(response);
      return response = RoomModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
