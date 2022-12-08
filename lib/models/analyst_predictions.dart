// To parse this JSON data, do
//
//     final analystPredictions = analystPredictionsFromJson(jsonString);

import 'dart:convert';

import 'package:leagx/models/user_summary.dart';

List<UserSummary> analystPredictionsFromJson(String str) =>
    List<UserSummary>.from(
        json.decode(str).map((x) => UserSummary.fromJson(x)));

String analystPredictionsToJson(List<UserSummary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
