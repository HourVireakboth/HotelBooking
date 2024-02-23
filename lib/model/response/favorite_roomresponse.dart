import 'dart:convert';

FavoriteRoomResponseModel favoriteRoomResponseModelFromJson(String str) => FavoriteRoomResponseModel.fromJson(json.decode(str));

String favoriteRoomResponseModelToJson(FavoriteRoomResponseModel data) => json.encode(data.toJson());

class FavoriteRoomResponseModel {
    List<FavoriteData>? data;

    FavoriteRoomResponseModel({
        required this.data,
    });

    factory FavoriteRoomResponseModel.fromJson(Map<String, dynamic> json){ 
        return FavoriteRoomResponseModel(
            data: json["data"] == null ? [] : List<FavoriteData>.from(json["data"]!.map((x) => FavoriteData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FavoriteData {
    int? id;
    List<UserId>? userId;
    List<RoomId> ?roomId;
    RoomImage ?roomImage;
    List<RoomFeature> ? roomFeature;
    List<RoomFacility> ?roomFacility;
    DateTime ? createdAt;
    DateTime ? updatedAt;

    FavoriteData({
        required this.id,
        required this.userId,
        required this.roomId,
        required this.roomImage,
        required this.roomFeature,
        required this.roomFacility,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FavoriteData.fromJson(Map<String, dynamic> json){ 
        return FavoriteData(
            id: json["id"],
            userId: json["user_id"] == null ? [] : List<UserId>.from(json["user_id"]!.map((x) => UserId.fromJson(x))),
            roomId: json["room_id"] == null ? [] : List<RoomId>.from(json["room_id"]!.map((x) => RoomId.fromJson(x))),
            roomImage: json["room_image"] == null ? null : RoomImage.fromJson(json["room_image"]),
            roomFeature: json["room_feature"] == null ? [] : List<RoomFeature>.from(json["room_feature"]!.map((x) => RoomFeature.fromJson(x))),
            roomFacility: json["room_facility"] == null ? [] : List<RoomFacility>.from(json["room_facility"]!.map((x) => RoomFacility.fromJson(x))),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": List<dynamic>.from(userId!.map((x) => x.toJson())),
        "room_id": List<dynamic>.from(roomId!.map((x) => x.toJson())),
        "room_image": roomImage!.toJson(),
        "room_feature": List<dynamic>.from(roomFeature!.map((x) => x.toJson())),
        "room_facility": List<dynamic>.from(roomFacility!.map((x) => x.toJson())),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

class RoomFacility {
    int ?id;
    String ?icon;
    String ?name;
    String ?description;
    DateTime ? createdAt;
    DateTime ?updatedAt;
    RoomFacilityPivot ?pivot;

    RoomFacility({
        required this.id,
        required this.icon,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory RoomFacility.fromJson(Map<String, dynamic> json){ 
        return RoomFacility(
            id: json["id"],
            icon: json["icon"],
            name: json["name"],
            description: json["description"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            pivot: json["pivot"] == null ? null : RoomFacilityPivot.fromJson(json["pivot"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "name": name,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "pivot": pivot!.toJson(),
    };
}

class RoomFacilityPivot {
    int ? roomId;
    int ? facilityId;

    RoomFacilityPivot({
        required this.roomId,
        required this.facilityId,
    });

    factory RoomFacilityPivot.fromJson(Map<String, dynamic> json){ 
        return RoomFacilityPivot(
            roomId: json["room_id"],
            facilityId: json["facility_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "facility_id": facilityId,
    };
}

class RoomFeature {
    int ?id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    RoomFeaturePivot? pivot;

    RoomFeature({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory RoomFeature.fromJson(Map<String, dynamic> json){ 
        return RoomFeature(
            id: json["id"],
            name: json["name"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            pivot: json["pivot"] == null ? null : RoomFeaturePivot.fromJson(json["pivot"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "pivot": pivot!.toJson(),
    };
}

class RoomFeaturePivot {
    int? roomId;
    int ?featureId;

    RoomFeaturePivot({
        required this.roomId,
        required this.featureId,
    });

    factory RoomFeaturePivot.fromJson(Map<String, dynamic> json){ 
        return RoomFeaturePivot(
            roomId: json["room_id"],
            featureId: json["feature_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "feature_id": featureId,
    };
}

class RoomId {
    int? id;
    String? name;
    int? area;
    int? price;
    int? quantity;
    int? adult;
    int? children;
    String? description;
    int? status;
    int? removed;
    DateTime? createdAt;
    DateTime? updatedAt;

    RoomId({
        required this.id,
        required this.name,
        required this.area,
        required this.price,
        required this.quantity,
        required this.adult,
        required this.children,
        required this.description,
        required this.status,
        required this.removed,
        required this.createdAt,
        required this.updatedAt,
    });

    factory RoomId.fromJson(Map<String, dynamic> json){ 
        return RoomId(
            id: json["id"],
            name: json["name"],
            area: json["area"],
            price: json["price"],
            quantity: json["quantity"],
            adult: json["adult"],
            children: json["children"],
            description: json["description"],
            status: json["status"],
            removed: json["removed"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "price": price,
        "quantity": quantity,
        "adult": adult,
        "children": children,
        "description": description,
        "status": status,
        "removed": removed,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

class RoomImage {
    int? id;
    int? roomId;
    String? image;
    int? thumb;
    DateTime? createdAt;
    DateTime? updatedAt;

    RoomImage({
        required this.id,
        required this.roomId,
        required this.image,
        required this.thumb,
        required this.createdAt,
        required this.updatedAt,
    });

    factory RoomImage.fromJson(Map<String, dynamic> json){ 
        return RoomImage(
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
    int? id;
    String? name;
    String? email;
    String? address;
    String phonenum;
    int ? pincode;
    DateTime ? dob;
    String ? profile;
    String ? gender;
    int ? status;
    DateTime ? emailVerifiedAt;
    DateTime ?  createdAt;
    DateTime? updatedAt;

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
