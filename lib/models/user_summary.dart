// To parse this JSON data, do
//
//     final userSummary = userSummaryFromJson(jsonString);

import 'dart:convert';

import 'package:leagx/models/subscription_plan.dart';
import 'package:leagx/ui/screens/choose_plan/components/plan_listing.dart';

UserSummary userSummaryFromJson(String str) =>
    UserSummary.fromJson(json.decode(str));

String userSummaryToJson(UserSummary data) => json.encode(data.toJson());

class UserSummary {
  UserSummary({
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
    required this.coinEarned,
    required this.remainingPredictions,
    required this.currentPlan
    //required this.userDevices,
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
  num? totalPredictions;
  num? predictionSuccessRate;
  num? coinEarned;
  int? remainingPredictions;
  SubscriptionPlan? currentPlan; 
  //List<dynamic> userDevices;

  factory UserSummary.fromJson(Map<String, dynamic> json) => UserSummary(
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
        totalPredictions: json["total_predictions"] ?? 0,
        predictionSuccessRate: json["prediction_success_rate"] ?? 0.0,
        coinEarned: json["coin_earned"] ?? 0,
        remainingPredictions: json["remaining_prediction_count"] ?? 0,
        currentPlan: json["current_plan"] != null ? SubscriptionPlan.fromJson(json["current_plan"]) : null
        //userDevices: List<dynamic>.from(json["user_devices"].map((x) => x)),
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
        "coin_earned": coinEarned,
        "remaining_prediction_count": remainingPredictions,
        //"user_devices": List<dynamic>.from(userDevices.map((x) => x)),
      };
}
