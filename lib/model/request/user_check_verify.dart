import 'dart:convert';

CheckVerifyRequest checkVerifyRequestFromJson(String str) => CheckVerifyRequest.fromJson(json.decode(str));

String checkVerifyRequestToJson(CheckVerifyRequest data) => json.encode(data.toJson());

class CheckVerifyRequest {
    String? code;

    CheckVerifyRequest({
        required this.code,
    });
    factory CheckVerifyRequest.fromJson(Map<String, dynamic> json){ 
        return CheckVerifyRequest(
            code: json["code"],
        );
    }
    Map<String, dynamic> toJson() => {
        "code": code,
    };
}