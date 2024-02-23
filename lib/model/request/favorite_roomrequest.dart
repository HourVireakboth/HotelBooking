import 'dart:convert';

FavoriteRoomRequestModel favoriteRoomRequestModelFromJson(String str) => FavoriteRoomRequestModel.fromJson(json.decode(str));

String favoriteRoomRequestModelToJson(FavoriteRoomRequestModel data) => json.encode(data.toJson());

class FavoriteRoomRequestModel {
    int ?roomId;
    int ?userId;

    FavoriteRoomRequestModel({
        required this.roomId,
        required this.userId,
    });

    factory FavoriteRoomRequestModel.fromJson(Map<String, dynamic> json){ 
        return FavoriteRoomRequestModel(
            roomId: json["room_id"],
            userId: json["user_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "user_id": userId,
    };
}