import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/api_repsonse.dart';
import 'package:hotel_booking_app/model/response/userloginresponse.dart';
import 'package:hotel_booking_app/repository/user_repository.dart';

import '../data/network/network_api_service.dart';

class UserViewModel extends ChangeNotifier {
  final _userRepo = UserRepository();

  // var apiResponse = ApiReponse.loading();
  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  ApiReponse<AuthLoginResponse> apiResponse = ApiReponse();
  setApiResponse(ApiReponse<AuthLoginResponse> response) {
    apiResponse = response;
    notifyListeners();
  }

  

  Future<dynamic> postUser(email, password) async {
    await _userRepo.postUser(email, password).then((response) {
      if (NetworkApiService.statuscode == 402) {
        print("status 402 : $response");
        return setApiResponse(ApiReponse.error('Sorry, your password is incorrect. Please try again or reset your password.'));
      } else if (NetworkApiService.statuscode == 200) {
        return setApiResponse(ApiReponse.completed(response));
      } else if (NetworkApiService.statuscode == 404) {
        return setApiResponse(
            ApiReponse.error("Your Email does not exist! Please try again."));
      } else if (NetworkApiService.statuscode == 422) {
        return setApiResponse(ApiReponse.error(
            "Your account not verify yet! Please check your email and Verify to get Login."));
      }
    }).onError((error, stackTrace) =>
        setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> registerUser(name, email, password) async {
    await _userRepo
        .registerUser(name, email, password)
        .then((value) => setApiResponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> updateUser(
      token, name, address, phonenumber, pincode, dob, gender) async {
    await _userRepo
        .updateUser(token, name, address, phonenumber, pincode, dob, gender)
        .then((value) => setApiResponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> updateUserProfile(token, pathFile) async {
    await _userRepo
        .updateUserProfile(token, pathFile)
        .then((value) => setApiResponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> sendEmails(email) async {
    await _userRepo.sendEmail(email).then((value) {
      if (NetworkApiService.statuscode == 422) {
        return setApiResponse(
            ApiReponse.error('Email not found please try again!'));
      } else if (NetworkApiService.statuscode == 200) {
        return setApiResponse(ApiReponse.completed(value));
      }
    }).onError((error, stackTrace) =>
        setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> sendCode(code) async {
    await _userRepo.checkCode(code).then((value) {
      if (NetworkApiService.statuscode == 500) {
        return setApiResponse(ApiReponse.error('Verify code incorrect!'));
      } else if (NetworkApiService.statuscode == 200) {
        return setApiResponse(ApiReponse.completed(value));
      }
    }).onError((error, stackTrace) =>
        setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }

  Future<dynamic> sendChangePassword(code, password) async {
    await _userRepo
        .changePassword(code, password)
        .then((value) => setApiResponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiResponse(ApiReponse.error(error.toString())));
    print('userRepo:$_userRepo');
  }
}
