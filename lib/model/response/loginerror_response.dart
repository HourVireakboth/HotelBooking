import 'dart:convert';

LoginMessageResponse loginMessageResponseFromJson(String str) => LoginMessageResponse.fromJson(json.decode(str));

String loginMessageResponseToJson(LoginMessageResponse data) => json.encode(data.toJson());

class LoginMessageResponse {
    String message;

    LoginMessageResponse({
        required this.message,
    });

    factory LoginMessageResponse.fromJson(Map<String, dynamic> json){ 
        return LoginMessageResponse(
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}