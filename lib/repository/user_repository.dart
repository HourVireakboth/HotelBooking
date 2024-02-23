import 'package:hotel_booking_app/data/network/network_api_service.dart';
import 'package:hotel_booking_app/model/request/user_change_pw.dart';
import 'package:hotel_booking_app/model/request/user_check_verify.dart';
import 'package:hotel_booking_app/model/request/user_email_request.dart';
import 'package:hotel_booking_app/model/request/user_resgister.dart';
import 'package:hotel_booking_app/model/request/userloginrequest.dart';
import 'package:hotel_booking_app/model/response/loginerror_response.dart';
import 'package:hotel_booking_app/model/response/userloginresponse.dart';
import 'package:hotel_booking_app/res/app_url.dart';

class UserRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> postUser(email, password) async {
    try {
      var userModel = AuthLoginRequest(email: email, password: password);
      dynamic response =
          await _apiService.postApi(AppUrl.login, userModel.toJson());
      print('Response : $response');
      if (NetworkApiService.statuscode == 200) {
        print(AuthLoginResponse.fromJson(response));
        return response = AuthLoginResponse.fromJson(response);
      } else if (NetworkApiService.statuscode == 402) {
        print('Status 402 = ${LoginMessageResponse.fromJson(response)}');
        return response = LoginMessageResponse.fromJson(response);
      } else if (NetworkApiService.statuscode == 404) {
        print('Status 404 = ${LoginMessageResponse.fromJson(response)}');
        return response = LoginMessageResponse.fromJson(response);
      } else {
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sendEmail(email) async {
    try {
      var userModel = EmailRequest(email: email);
      dynamic response = await _apiService.postEmail(
          AppUrl.sendEmailForgetpw, userModel.toJson());
      print('Response : $response');
      //print(.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkCode(code) async {
    try {
      var userModel = CheckVerifyRequest(code: code);
      dynamic response =
          await _apiService.postCode(AppUrl.checkcode, userModel.toJson());
      print('Response : $response');
      //print(.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> changePassword(code, password) async {
    try {
      var userModel = ChangePasswordRequest(code: code, password: password);
      dynamic response =
          await _apiService.postCode(AppUrl.resetPassword, userModel.toJson());
      print('Response : $response');
      //print(.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerUser(name, email, password) async {
    try {
      var userModel =
          RegisterModel(name: name, email: email, password: password);
      dynamic response =
          await _apiService.postApi(AppUrl.register, userModel.toJson());
      print('Response : $response');
      //print(AuthLoginResponse.fromJson(response));
      return response = AuthLoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUser(
      token, name, address, phonenumber, pincode, dob, gender) async {
    try {
      // var userModel = UpdateModel(
      //     name: name,
      //     address: address,
      //     phonenum: phonenumber,
      //     pincode: pincode,
      //     dob: dob,
      //     gender: gender);
      dynamic response = await _apiService.putApi(AppUrl.update, token, name,
          address, phonenumber, pincode, dob, gender);
      print('Response : $response');
      //print(AuthLoginResponse.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserProfile(token, pathFile) async {
    try {
      dynamic response = await _apiService.postProfileApi(
          AppUrl.updateProfile, token, pathFile);
      print('Response : $response');
      //print(AuthLoginResponse.fromJson(response));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
