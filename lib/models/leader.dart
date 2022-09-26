// To parse this JSON data, do
//
//     final leader = leaderFromJson(jsonString);

import 'dart:convert';

List<Leader> leaderFromJson(String str) =>
    List<Leader>.from(json.decode(str).map((x) => Leader.fromJson(x)));

String leaderToJson(List<Leader> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leader {
  Leader({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.gender,
    required this.address,
    required this.apiToken,
    required this.role,
    required this.dob,
    required this.profileImg,
    required this.coverImg,
    required this.provider,
    required this.uid,
    required this.language,
    required this.notification,
    required this.totalPredictions,
    required this.predictionSuccessRate,
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
  String? apiToken;
  String? role;
  String? dob;
  String? profileImg;
  String? coverImg;
  String? provider;
  String? uid;
  String? language;
  String notification;
  int totalPredictions;
  int predictionSuccessRate;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        id: json["id"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        phone: json["phone"] ?? "",
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
        totalPredictions: json["total_predictions"] ?? 0,
        predictionSuccessRate: json["prediction_success_rate"] ?? 0,
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
        "total_predictions": totalPredictions,
        "prediction_success_rate": predictionSuccessRate,
      };
}
