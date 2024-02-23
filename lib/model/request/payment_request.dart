import 'dart:convert';

PaymentRequestModel bookingRequestModelFromJson(String str) =>
    PaymentRequestModel.fromJson(json.decode(str));

String bookingRequestModelToJson(PaymentRequestModel data) =>
    json.encode(data.toJson());

class PaymentRequestModel {
  int? roomId;
  int? userId;
  DateTime? checkIn;
  DateTime? checkOut;

  PaymentRequestModel({
    required this.roomId,
    required this.userId,
    required this.checkIn,
    required this.checkOut,
  });

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      roomId: json["room_id"],
      userId: json["user_id"],
      checkIn: DateTime.tryParse(json["check_in"] ?? ""),
      checkOut: DateTime.tryParse(json["check_out"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "user_id": userId,
        "check_in":
            "${checkIn!.year.toString().padLeft(4, '0')}-${checkIn!.month.toString().padLeft(2, '0')}-${checkIn!.day.toString().padLeft(2, '0')}",
        "check_out":
            "${checkOut!.year.toString().padLeft(4, '0')}-${checkOut!.month.toString().padLeft(2, '0')}-${checkOut!.day.toString().padLeft(2, '0')}",
      };
}
