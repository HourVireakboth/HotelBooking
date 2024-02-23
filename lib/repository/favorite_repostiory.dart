import 'package:hotel_booking_app/model/response/favorite_roomresponse.dart';

import '../data/network/network_api_service.dart';

class FavoriteRepostiory {
  final _apiService = NetworkApiService();

  Future<dynamic> postFavoriteRoom(roomid, userid) async {
    try {
      dynamic response = await _apiService.postFavorite(roomid, userid);
      print('Response : $response');
      //print(FavoriteRoomResponseModel.fromJson(response));
      return response;
      //= FavoriteRoomResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getFavoriteRoom(token) async {
    try {
      dynamic response = await _apiService.getFavoriteApi(
          'http://127.0.0.1:8000/api/favoriterooms', token);
      print('Response : $response');
      print(FavoriteRoomResponseModel.fromJson(response));
      return response = FavoriteRoomResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFavorite(favoriteid) async {
    try {
      dynamic response = await _apiService
          .deleteFavorite('http://127.0.0.1:8000/api/favoriteroom/$favoriteid');
      print('Response : $response');
      //print(FavoriteRoomResponseModel.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
