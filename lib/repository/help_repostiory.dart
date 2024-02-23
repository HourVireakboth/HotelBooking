import 'package:hotel_booking_app/model/request/user_helprequest.dart';
import 'package:hotel_booking_app/res/app_url.dart';

import '../data/network/network_api_service.dart';

class HelpRepostiory {
  final _apiService = NetworkApiService();

  Future<dynamic> postHelp(name, email, subject, message) async {
    try {
      var helpModel = HelpUserRequestModel(name: name, email: email, subject: subject, message: message);
      dynamic response = await _apiService.postHelpApi(AppUrl.userHelp,helpModel.toJson());
      print('Response : $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}