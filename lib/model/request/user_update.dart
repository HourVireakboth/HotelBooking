import 'dart:convert';

UpdateModel updateModelFromJson(String str) => UpdateModel.fromJson(json.decode(str));

String updateModelToJson(UpdateModel data) => json.encode(data.toJson());

class UpdateModel {
    String? name;
    String? address;
    String? phonenum;
    String? pincode;
    DateTime? dob;
    String? gender;

    UpdateModel({
        required this.name,
        required this.address,
        required this.phonenum,
        required this.pincode,
        required this.dob,
        required this.gender,
    });

    factory UpdateModel.fromJson(Map<String, dynamic> json){ 
        return UpdateModel(
            name: json["name"],
            address: json["address"],
            phonenum: json["phonenum"],
            pincode: json["pincode"],
            dob: DateTime.tryParse(json["dob"] ?? ""),
            gender: json["gender"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phonenum": phonenum,
        "pincode": pincode,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
    };
}