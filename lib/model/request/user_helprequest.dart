import 'dart:convert';

HelpUserRequestModel helpUserRequestModelFromJson(String str) => HelpUserRequestModel.fromJson(json.decode(str));

String helpUserRequestModelToJson(HelpUserRequestModel data) => json.encode(data.toJson());

class HelpUserRequestModel {
    String? name;
    String? email;
    String? subject;
    String? message;

    HelpUserRequestModel({
        required this.name,
        required this.email,
        required this.subject,
        required this.message,
    });

   factory HelpUserRequestModel.fromJson(Map<String, dynamic> json){ 
        return HelpUserRequestModel(
            name: json["name"],
            email: json["email"],
            subject: json["subject"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "subject": subject,
        "message": message,
    };
}