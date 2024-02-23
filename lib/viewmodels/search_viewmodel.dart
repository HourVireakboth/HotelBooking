import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/model/response/searchrespornse.dart';
import 'package:hotel_booking_app/repository/search_room_repostiory.dart';

import '../data/response/api_repsonse.dart';

class SearchViewModel extends ChangeNotifier{
    final _searchRepo = SearchRepostiory();

    
 ApiReponse<SearchResponseModel> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<SearchResponseModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> searchRooms(name) async {
      await _searchRepo
        .searchRoom(name)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
        print(apiResponse);
  }


}