import 'dart:convert';

AuthLoginRequest authLoginFromJson(String str) => AuthLoginRequest.fromJson(json.decode(str));

String authLoginToJson(AuthLoginRequest data) => json.encode(data.toJson());

class AuthLoginRequest {
    String? email;
    String? password;

    AuthLoginRequest({
         this.email,
         this.password,
    });

    factory AuthLoginRequest.fromJson(Map<String, dynamic> json){
        return AuthLoginRequest(
            email: json["email"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}