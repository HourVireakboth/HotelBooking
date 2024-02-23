import 'dart:convert';

AuthLoginResponse authLoginResponseFromJson(String str) => AuthLoginResponse.fromJson(json.decode(str));

String authLoginResponseToJson(AuthLoginResponse data) => json.encode(data.toJson());

class AuthLoginResponse {
    User? user;

    AuthLoginResponse({
        required this.user,
    });

    factory AuthLoginResponse.fromJson(Map<String, dynamic> json){ 
        return AuthLoginResponse(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
    };
}
class User {
    int? id;
    String? name;
    String? email;
    String? address;
    String? phonenum;
    int? pincode;
    DateTime? dob;
    String? profile;
    String? gender;
    int? status;
    DateTime? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? token;

    User({
         this.id,
         this.name,
         this.email,
         this.address,
         this.phonenum,
         this.pincode,
         this.dob,
         this.profile,
         this.gender,
         this.status,
         this.emailVerifiedAt,
         this.createdAt,
         this.updatedAt,
         this.token,
    });

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
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
            token: json["token"],
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
        "token": token!,
    };
}