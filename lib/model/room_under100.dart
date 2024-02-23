import 'dart:convert';

RoomUnder100Model roomUnder100ModelFromJson(String str) =>
    RoomUnder100Model.fromJson(json.decode(str));

String roomUnder100ModelToJson(RoomUnder100Model data) =>
    json.encode(data.toJson());

class RoomUnder100Model {
  List<RoomUnder100Data> data;

  RoomUnder100Model({
    required this.data,
  });

  factory RoomUnder100Model.fromJson(Map<String, dynamic> json) {
    return RoomUnder100Model(
      data: json["data"] == null
          ? []
          : List<RoomUnder100Data>.from(
              json["data"]!.map((x) => RoomUnder100Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RoomUnder100Data {
  int? id;
  String? name;
  int? area;
  int? quantity;
  int? adult;
  int? children;
  int? price;
  String? description;
  int? removed;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<RoomImage>? roomImage;
  List<RoomFeature>? roomFeature;
  List<RoomFacility>? roomFacility;

  RoomUnder100Data({
    required this.id,
    required this.name,
    required this.area,
    required this.quantity,
    required this.adult,
    required this.children,
    required this.price,
    required this.description,
    required this.removed,
    required this.createdAt,
    required this.updatedAt,
    required this.roomImage,
    required this.roomFeature,
    required this.roomFacility,
  });
  factory RoomUnder100Data.fromJson(Map<String, dynamic> json) {
    return RoomUnder100Data(
      id: json["id"],
      name: json["name"],
      area: json["area"],
      quantity: json["quantity"],
      adult: json["adult"],
      children: json["children"],
      price: json["price"],
      description: json["description"],
      removed: json["removed"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      roomImage: json["room_image"] == null
          ? []
          : List<RoomImage>.from(
              json["room_image"]!.map((x) => RoomImage.fromJson(x))),
      roomFeature: json["room_feature"] == null
          ? []
          : List<RoomFeature>.from(
              json["room_feature"]!.map((x) => RoomFeature.fromJson(x))),
      roomFacility: json["room_facility"] == null
          ? []
          : List<RoomFacility>.from(
              json["room_facility"]!.map((x) => RoomFacility.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "quantity": quantity,
        "adult": adult,
        "children": children,
        "price": price,
        "description": description,
        "removed": removed,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "room_image": List<dynamic>.from(roomImage!.map((x) => x.toJson())),
        "room_feature": List<dynamic>.from(roomFeature!.map((x) => x.toJson())),
        "room_facility":
            List<dynamic>.from(roomFacility!.map((x) => x.toJson())),
      };
}

class RoomFacility {
  int? id;
  String ?icon;
  String? name;
  String? description;
  DateTime ?createdAt;
  DateTime ?updatedAt;
  RoomFacilityPivot? pivot;

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
  int? roomId;
  int ?facilityId;

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
  int? id;
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
  int? featureId;

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
