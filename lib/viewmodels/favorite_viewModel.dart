import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/model/response/favorite_roomresponse.dart';
import 'package:hotel_booking_app/repository/favorite_repostiory.dart';
import '../data/response/api_repsonse.dart';

class FavoriteViewModel extends ChangeNotifier {
  final _favoriteRepo = FavoriteRepostiory();

  // var apiResponse = ApiReponse();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<FavoriteRoomResponseModel> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<FavoriteRoomResponseModel> response) {
    apiResponse = response;
    notifyListeners();
  }
  
  Future<dynamic> getfavoriteRoom(token) async {
    await _favoriteRepo
        .getFavoriteRoom(token)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

  Future<dynamic> postfavoriteRoom(roomid,userid) async {
    await _favoriteRepo
        .postFavoriteRoom(roomid, userid)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

  Future<dynamic> deletefavoriteRoom(favoriteid) async {
    await _favoriteRepo
        .deleteFavorite(favoriteid)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }
}