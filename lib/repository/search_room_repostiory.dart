
import 'package:hotel_booking_app/model/response/searchrespornse.dart';
import '../data/network/network_api_service.dart';

class SearchRepostiory {
  final _apiService = NetworkApiService();
Future<SearchResponseModel> searchRoom(search) async {
    try {
      dynamic response = await _apiService.getRoomApi('http://127.0.0.1:8000/api/find-room/name?name=$search');
      return response = SearchResponseModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}