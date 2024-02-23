import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/model/room_under100.dart';
import 'package:hotel_booking_app/repository/room_under100repostiory.dart';
import '../data/response/api_repsonse.dart';

class RoomUnder100ViewModel extends ChangeNotifier{
    final _roomRepo = RoomUnder100Repostiory();

  

  // var apiResponse = ApiReponse();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<RoomUnder100Model> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<RoomUnder100Model> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> getRoomUnder100() async {
      await _roomRepo
        .getAllRoomUnder100()
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

}