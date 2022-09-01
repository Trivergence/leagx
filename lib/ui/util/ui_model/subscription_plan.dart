import 'package:leagx/constants/colors.dart';
import 'package:flutter/material.dart';

class SubscriptionPlan {
  String? title;
  List<String>? desc;
  double? price;
  Gradient? gradient;
  SubscriptionPlan({this.title, this.desc, this.price, this.gradient});
}

List<SubscriptionPlan> listOfPlans = [
  SubscriptionPlan(
    title: "Silver",
    desc: ["5 Predictions", "5 analyst subscriptions", "5 full club profiles"],
    price: 5.00,
    gradient: AppColors.blueishBottomTopGradient,
  ),
  SubscriptionPlan(
    title: "Gold",
    desc: [
      "unlimited predictions",
      "unlimited analyst subscriptions",
      "unlimited club profiles"
    ],
    price: 10.00,
    gradient: AppColors.orangishGradient,
  ),
  SubscriptionPlan(
    title: "Platinum",
    desc: [
      "Live prediction advisor",
      "Live analyst feeds",
      "Live player analytics"
    ],
    price: 15.00,
    gradient: AppColors.pinkishGradient,
  ),
  SubscriptionPlan(
    title: "Diamond (by invitation)",
    desc: [
      "You become an advisor",
      "You write analyst feeds",
      "You earn a profit share"
    ],
    price: 5.00,
    gradient: AppColors.blueishGradient,
  )
];
