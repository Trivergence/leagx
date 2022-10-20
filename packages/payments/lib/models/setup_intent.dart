// To parse this JSON data, do
//
//     final setupIntent = setupIntentFromJson(jsonString);

import 'dart:convert';

SetupIntent setupIntentFromJson(String str) =>
    SetupIntent.fromJson(json.decode(str));

String setupIntentToJson(SetupIntent data) => json.encode(data.toJson());

class SetupIntent {
  SetupIntent({
    this.id,
    this.object,
    this.application,
    this.cancellationReason,
    this.clientSecret,
    this.created,
    this.customer,
    this.description,
    this.flowDirections,
    this.lastSetupError,
    this.latestAttempt,
    this.livemode,
    this.mandate,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.singleUseMandate,
    this.status,
    this.usage,
  });

  String? id;
  String? object;
  dynamic application;
  dynamic cancellationReason;
  String? clientSecret;
  int? created;
  dynamic customer;
  dynamic description;
  dynamic flowDirections;
  dynamic lastSetupError;
  dynamic latestAttempt;
  bool? livemode;
  dynamic mandate;
  Metadata? metadata;
  dynamic nextAction;
  dynamic onBehalfOf;
  dynamic paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic singleUseMandate;
  String? status;
  String? usage;

  factory SetupIntent.fromJson(Map<String, dynamic> json) => SetupIntent(
        id: json["id"],
        object: json["object"],
        application: json["application"],
        cancellationReason: json["cancellation_reason"],
        clientSecret: json["client_secret"],
        created: json["created"],
        customer: json["customer"],
        description: json["description"],
        flowDirections: json["flow_directions"],
        lastSetupError: json["last_setup_error"],
        latestAttempt: json["latest_attempt"],
        livemode: json["livemode"],
        mandate: json["mandate"],
        metadata: Metadata.fromJson(json["metadata"]),
        nextAction: json["next_action"],
        onBehalfOf: json["on_behalf_of"],
        paymentMethod: json["payment_method"],
        paymentMethodOptions:
            PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes:
            List<String>.from(json["payment_method_types"].map((x) => x)),
        singleUseMandate: json["single_use_mandate"],
        status: json["status"],
        usage: json["usage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "application": application,
        "cancellation_reason": cancellationReason,
        "client_secret": clientSecret,
        "created": created,
        "customer": customer,
        "description": description,
        "flow_directions": flowDirections,
        "last_setup_error": lastSetupError,
        "latest_attempt": latestAttempt,
        "livemode": livemode,
        "mandate": mandate,
        "metadata": metadata != null ? metadata!.toJson() : null,
        "next_action": nextAction,
        "on_behalf_of": onBehalfOf,
        "payment_method": paymentMethod,
        "payment_method_options": paymentMethodOptions != null ? paymentMethodOptions!.toJson() : null,
        "payment_method_types": paymentMethodTypes != null ?
            List<dynamic>.from(paymentMethodTypes!.map((x) => x)) : null,
        "single_use_mandate": singleUseMandate,
        "status": status,
        "usage": usage,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  Card? card;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "card": card != null ? card!.toJson() : null,
      };
}

class Card {
  Card({
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  dynamic mandateOptions;
  dynamic network;
  String? requestThreeDSecure;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        mandateOptions: json["mandate_options"],
        network: json["network"],
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toJson() => {
        "mandate_options": mandateOptions,
        "network": network,
        "request_three_d_secure": requestThreeDSecure,
      };
}
