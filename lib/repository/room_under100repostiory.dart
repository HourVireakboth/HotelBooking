import 'package:hotel_booking_app/model/room_under100.dart';

import '../data/network/network_api_service.dart';
import '../res/app_url.dart';

class RoomUnder100Repostiory{
final _apiService = NetworkApiService();
  Future<RoomUnder100Model> getAllRoomUnder100() async {
    try {
      dynamic response = await _apiService.getRoomApi(AppUrl.getRoomUnder100);
      print(response);
      return response = RoomUnder100Model.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}