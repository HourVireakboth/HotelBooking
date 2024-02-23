import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/repository/help_repostiory.dart';

import '../data/response/api_repsonse.dart';


class HelpViewModel extends ChangeNotifier{
    final _helpRepo = HelpRepostiory();
 ApiReponse<dynamic> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<dynamic> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> userHelp(name, email, subject, message) async {
      await _helpRepo
        .postHelp(name, email, subject, message)
        .then((response) => setApiResponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
        print(apiResponse);
  }


}