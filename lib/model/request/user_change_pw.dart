import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
    String? code;
    String? password;

    ChangePasswordRequest({
        required this.code,
        required this.password,
    });

    factory ChangePasswordRequest.fromJson(Map<String, dynamic> json){ 
        return ChangePasswordRequest(
            code: json["code"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "password": password,
    };
}