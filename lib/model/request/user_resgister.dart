import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String? name;
    String? email;
    String? password;

    RegisterModel({
         this.name,
         this.email,
         this.password,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json){ 
        return RegisterModel(
            name: json["name"],
            email: json["email"],
            password: json["password"],
        );
    }
    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
    };
}