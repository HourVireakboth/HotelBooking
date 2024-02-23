import 'dart:convert';

BookingResponseModel bookingResponseModelFromJson(String str) => BookingResponseModel.fromJson(json.decode(str));

String bookingResponseModelToJson(BookingResponseModel data) => json.encode(data.toJson());

class BookingResponseModel {
    List<BookingData>? data;

    BookingResponseModel({
        required this.data,
    });

     factory BookingResponseModel.fromJson(Map<String, dynamic> json){ 
        return BookingResponseModel(
            data: json["data"] == null ? [] : List<BookingData>.from(json["data"]!.map((x) => BookingData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BookingData {
    int ?id;
    UserId ? userId;
    RoomId ?roomId;
    DateTime ?checkIn;
    DateTime ?checkOut;
    int ?arrival;
    dynamic refund;
    String ?bookingStatus;
    int ?amount;
    String ?currency;
    String ?stripePaymentId;
    dynamic paymentIntentId;
    int ?paid;
    dynamic paidAt;
    int ?captured;
    dynamic capturedAt;
    dynamic paymentStatus;
    dynamic paymentMethod;
    dynamic rateReview;
    List<BookingDetail> ?bookingDetails;
    List<dynamic> ?ratingReviews;

    BookingData({
        required this.id,
        required this.userId,
        required this.roomId,
        required this.checkIn,
        required this.checkOut,
        required this.arrival,
        this.refund,
        required this.bookingStatus,
        required this.amount,
        required this.currency,
        required this.stripePaymentId,
        this.paymentIntentId,
        required this.paid,
        this.paidAt,
        required this.captured,
        this.capturedAt,
        this.paymentStatus,
        this.paymentMethod,
        this.rateReview,
        required this.bookingDetails,
        required this.ratingReviews,
    });

    factory BookingData.fromJson(Map<String, dynamic> json){ 
        return BookingData(
            id: json["id"],
            userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
            roomId: json["room_id"] == null ? null : RoomId.fromJson(json["room_id"]),
            checkIn: DateTime.tryParse(json["check_in"] ?? ""),
            checkOut: DateTime.tryParse(json["check_out"] ?? ""),
            arrival: json["arrival"],
            refund: json["refund"],
            bookingStatus: json["booking_status"],
            amount: json["amount"],
            currency: json["currency"],
            stripePaymentId: json["stripe_payment_id"],
            paymentIntentId: json["payment_intent_id"],
            paid: json["paid"],
            paidAt: json["paid_at"],
            captured: json["captured"],
            capturedAt: json["captured_at"],
            paymentStatus: json["payment_status"],
            paymentMethod: json["payment_method"],
            rateReview: json["rate_review"],
            bookingDetails: json["bookingDetails"] == null ? [] : List<BookingDetail>.from(json["bookingDetails"]!.map((x) => BookingDetail.fromJson(x))),
            ratingReviews: json["ratingReviews"] == null ? [] : List<dynamic>.from(json["ratingReviews"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId!.toJson(),
        "room_id": roomId!.toJson(),
        "check_in": "${checkIn!.year.toString().padLeft(4, '0')}-${checkIn!.month.toString().padLeft(2, '0')}-${checkIn!.day.toString().padLeft(2, '0')}",
        "check_out": "${checkOut!.year.toString().padLeft(4, '0')}-${checkOut!.month.toString().padLeft(2, '0')}-${checkOut!.day.toString().padLeft(2, '0')}",
        "arrival": arrival,
        "refund": refund,
        "booking_status": bookingStatus,
        "amount": amount,
        "currency": currency,
        "stripe_payment_id": stripePaymentId,
        "payment_intent_id": paymentIntentId,
        "paid": paid,
        "paid_at": paidAt,
        "captured": captured,
        "captured_at": capturedAt,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "rate_review": rateReview,
        "bookingDetails": List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
        "ratingReviews": List<dynamic>.from(ratingReviews!.map((x) => x)),
    };
}

class BookingDetail {
    int ?id;
    int ?bookingId;
    String? roomName;
    int ? price;
    int ?totalPay;
    dynamic roomNo;
    String ? userName;
    String  ?phonenum;
    String ?address;

    BookingDetail({
        required this.id,
        required this.bookingId,
        required this.roomName,
        required this.price,
        required this.totalPay,
        this.roomNo,
        required this.userName,
        required this.phonenum,
        required this.address,
    });

    factory BookingDetail.fromJson(Map<String, dynamic> json){ 
        return BookingDetail(
            id: json["id"],
            bookingId: json["booking_id"],
            roomName: json["room_name"],
            price: json["price"],
            totalPay: json["total_pay"],
            roomNo: json["room_no"],
            userName: json["user_name"],
            phonenum: json["phonenum"],
            address: json["address"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "room_name": roomName,
        "price": price,
        "total_pay": totalPay,
        "room_no": roomNo,
        "user_name": userName,
        "phonenum": phonenum,
        "address": address,
    };
}

class RoomId {
    int ?id;
    int ? roomId;
    String ? image;
    int thumb;
    DateTime ? createdAt;
    DateTime ? updatedAt;

    RoomId({
        required this.id,
        required this.roomId,
        required this.image,
        required this.thumb,
        required this.createdAt,
        required this.updatedAt,
    });

    factory RoomId.fromJson(Map<String, dynamic> json){ 
        return RoomId(
            id: json["id"],
            roomId: json["room_id"],
            image: json["image"],
            thumb: json["thumb"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "image": image,
        "thumb": thumb,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

class UserId {
    int ? id;
    String? name;
    String ?email;
    String ? address;
    String  ? phonenum;
    int ? pincode;
    DateTime ? dob;
    String  ? profile;
    String ? gender;
    int ? status;
    DateTime  ? emailVerifiedAt;
    DateTime ? createdAt;
    DateTime  ? updatedAt;

    UserId({
        required this.id,
        required this.name,
        required this.email,
        required this.address,
        required this.phonenum,
        required this.pincode,
        required this.dob,
        required this.profile,
        required this.gender,
        required this.status,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserId.fromJson(Map<String, dynamic> json){ 
        return UserId(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            address: json["address"],
            phonenum: json["phonenum"],
            pincode: json["pincode"],
            dob: DateTime.tryParse(json["dob"] ?? ""),
            profile: json["profile"],
            gender: json["gender"],
            status: json["status"],
            emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phonenum": phonenum,
        "pincode": pincode,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "profile": profile,
        "gender": gender,
        "status": status,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
