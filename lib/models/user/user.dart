// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.address,
    required this.apiToken,
    this.role,
    this.dob,
    this.profileImg,
    this.coverImg,
    this.provider,
    this.uid,
    this.language,
    required this.notification,
  });

  int id;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String? firstName;
  String? lastName;
  String? phone;
  String? gender;
  String? address;
  String apiToken;
  String? role;
  String? dob;
  String? profileImg;
  String? coverImg;
  String? provider;
  String? uid;
  String? language;
  String notification;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        phone: json["phone"],
        gender: json["gender"],
        address: json["address"],
        apiToken: json["api_token"],
        role: json["role"],
        dob: json["dob"],
        profileImg: json["profile_img"] ?? "",
        coverImg: json["cover_img"] ?? "",
        provider: json["provider"],
        uid: json["uid"],
        language: json["language"],
        notification: json["notification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "gender": gender,
        "address": address,
        "api_token": apiToken,
        "role": role,
        "dob": dob,
        "profile_img": profileImg,
        "cover_img": coverImg,
        "provider": provider,
        "uid": uid,
        "language": language,
        "notification": notification,
      };
}
