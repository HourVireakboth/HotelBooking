import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class NetworkApiService {
  dynamic responseJson;
  dynamic responeSearchJson;
  //UserViewModel userViewModel = UserViewModel();
  static var statuscode;

  Future<dynamic> getRoomApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Not internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getBookingApi(String url, token) async {
    print('token:$token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      print(' response code : ${response.statusCode}');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postCancelBooking(int orderID) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/api/cancelbooking'));
    request.body = json.encode({"bookingId": orderID});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      print(' response code : ${response.statusCode}');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> getFavoriteApi(String url, token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse('http://127.0.0.1:8000/api/favoriterooms'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      print(' response code : ${response.statusCode}');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postFavorite(int roomid, int userid) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/api/favoriteroom'));
    request.body = json.encode({"room_id": roomid, "user_id": userid});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      print(' response code : ${response.statusCode}');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> deleteFavorite(String url) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(' response code : ${response.statusCode}');
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postBookingOrder(String url, requestModel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      print(' response code : ${response.statusCode}');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postHelpApi(String url, requestModel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/user_query'));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      //print(await response.stream.bytesToString());
      print('status:$statuscode');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postApi(String url, requestModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('Staus Code = ${response.statusCode}');
    if (response.statusCode == 200) {
      statuscode = response.statusCode;
      print('status:$statuscode');
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else if (response.statusCode == 402) {
      statuscode = response.statusCode;
      print('status:$statuscode');
      print(response.reasonPhrase);
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else if (response.statusCode == 404) {
      statuscode = response.statusCode;
      print('status:$statuscode');
      print(response.reasonPhrase);
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
      var res = await response.stream.bytesToString();
      return json.decode(res);
    }
  }

  Future<dynamic> postEmail(String url, requestModel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      statuscode = response.statusCode;
      print('status:$statuscode');
      print('200');
      // print(await response.stream.bytesToString());
      // var res = await response.stream.bytesToString();
      // return json.decode(res);
    } else if (response.statusCode == 422) {
      statuscode = response.statusCode;
      print('status:$statuscode');
      print('422');
      // var res = await response.stream.bytesToString();
      // return json.decode(res);
    }
  }

  Future<dynamic> postCode(String url, requestModel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      statuscode = response.statusCode;
      print("post code 200");
      print('status:$statuscode');
      print(response.reasonPhrase);
    } else if (response.statusCode == 500) {
      print("postcode 500");
      statuscode = response.statusCode;
      print('status:$statuscode');
      print(response.reasonPhrase);
      // var res = await response.stream.bytesToString();
      // return json.decode(res);
    }
  }

  Future<dynamic> postChange(String url, requestModel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> putApi(
      String url, token, name, address, phonenum, pincode, dob, gender) async {
    print('token:$token');
    print('name:$name');
    print('address:$address');
    print('phonenum:$phonenum');
    print('pincode:$pincode');
    print('dob:$dob');
    print('gender:$gender');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('PUT', Uri.parse('http://127.0.0.1:8000/api/user/update'));
    request.body = json.encode({
      "name": "$name",
      "address": "$address",
      "phonenum": "$phonenum",
      "pincode": "$pincode",
      "dob": "$dob",
      "gender": "$gender"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> postProfileApi(String url, token, pathfile) async {
    print('token:$token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('profile', '$pathfile'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      print(response.reasonPhrase);
    }
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw BadRequestException('please check your model request');
    }
  }
}
