import 'dart:convert';

EmailRequest emailRequestFromJson(String str) => EmailRequest.fromJson(json.decode(str));

String emailRequestToJson(EmailRequest data) => json.encode(data.toJson());

class EmailRequest {
    String? email;

    EmailRequest({
       this.email,
    });

    factory EmailRequest.fromJson(Map<String, dynamic> json){ 
        return EmailRequest(
            email: json["email"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}