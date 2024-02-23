import 'package:flutter/material.dart';
import 'package:hotel_booking_app/model/room.dart';

import 'package:hotel_booking_app/repository/room_repostiory.dart';


import '../data/response/api_repsonse.dart';

class RoomViewModel extends ChangeNotifier {
  final _roomRepo = RoomRepostiory();

  // var apiResponse = ApiReponse();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<RoomModel> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<RoomModel> response) {
    apiResponse = response;
    notifyListeners();
  }



  Future<dynamic> getRoomAll() async {
    await _roomRepo
        .getAllRoom()
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

}
