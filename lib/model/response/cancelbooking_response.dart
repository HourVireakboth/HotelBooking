import 'dart:convert';

CancelBookingResponseModel cancelBookingResponseModelFromJson(String str) => CancelBookingResponseModel.fromJson(json.decode(str));

String cancelBookingResponseModelToJson(CancelBookingResponseModel data) => json.encode(data.toJson());

class CancelBookingResponseModel {
    bool success;
    String message;

    CancelBookingResponseModel({
        required this.success,
        required this.message,
    });

    factory CancelBookingResponseModel.fromJson(Map<String, dynamic> json) => CancelBookingResponseModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}