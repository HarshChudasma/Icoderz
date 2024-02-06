import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? image;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? '',
    name: json["username"] ?? '',
    email: json["email"] ?? '',
    image: json["imageUrl"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": name,
    "email": email,
    "imageUrl": image,
  };

  Map<String, dynamic> toMapForUser() {
    return <String, dynamic>{
      'id': id,
      'username': name,
      'email': email,
      'imageUrl': image,
    };
  }

}
