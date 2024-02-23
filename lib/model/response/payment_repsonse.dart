import 'dart:convert';

PaymentResponseModel bookingResponseModelFromJson(String str) =>
    PaymentResponseModel.fromJson(json.decode(str));

String bookingResponseModelToJson(PaymentResponseModel data) =>
    json.encode(data.toJson());

class PaymentResponseModel {
  bool? success;
  String? message;
  BookingOrder? bookingOrder;
  BookingDetails? bookingDetails;

  PaymentResponseModel({
    required this.success,
    required this.message,
    required this.bookingOrder,
    required this.bookingDetails,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      success: json["success"],
      message: json["message"],
      bookingOrder: json["booking_order"] == null
          ? null
          : BookingOrder.fromJson(json["booking_order"]),
      bookingDetails: json["booking_details"] == null
          ? null
          : BookingDetails.fromJson(json["booking_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "booking_order": bookingOrder!.toJson(),
        "booking_details": bookingDetails!.toJson(),
      };
}

class BookingDetails {
  int? bookingId;
  String? roomName;
  int? price;
  int? totalPay;
  dynamic roomNo;
  String? userName;
  String? phonenum;
  String address;
  DateTime? updatedAt;
  DateTime? createdAt;
  int id;

  BookingDetails({
    required this.bookingId,
    required this.roomName,
    required this.price,
    required this.totalPay,
    this.roomNo,
    required this.userName,
    required this.phonenum,
    required this.address,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      bookingId: json["booking_id"],
      roomName: json["room_name"],
      price: json["price"],
      totalPay: json["total_pay"],
      roomNo: json["room_no"],
      userName: json["user_name"],
      phonenum: json["phonenum"],
      address: json["address"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "room_name": roomName,
        "price": price,
        "total_pay": totalPay,
        "room_no": roomNo,
        "user_name": userName,
        "phonenum": phonenum,
        "address": address,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}

class BookingOrder {
  int? userId;
  int? roomId;
  DateTime? checkIn;
  DateTime? checkOut;
  int? amount;
  String? currency;
  int? stripePaymentId;
  String bookingStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  BookingOrder({
    required this.userId,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.amount,
    required this.currency,
    required this.stripePaymentId,
    required this.bookingStatus,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory BookingOrder.fromJson(Map<String, dynamic> json) {
    return BookingOrder(
      userId: json["user_id"],
      roomId: json["room_id"],
      checkIn: DateTime.tryParse(json["check_in"] ?? ""),
      checkOut: DateTime.tryParse(json["check_out"] ?? ""),
      amount: json["amount"],
      currency: json["currency"],
      stripePaymentId: json["stripe_payment_id"],
      bookingStatus: json["booking_status"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "room_id": roomId,
        "check_in": checkIn!.toIso8601String(),
        "check_out": checkOut!.toIso8601String(),
        "amount": amount,
        "currency": currency,
        "stripe_payment_id": stripePaymentId,
        "booking_status": bookingStatus,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
