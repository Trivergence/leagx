// To parse this JSON data, do
//
//     final accountLink = accountLinkFromJson(jsonString);

import 'dart:convert';

AccountLink accountLinkFromJson(String str) =>
    AccountLink.fromJson(json.decode(str));

String accountLinkToJson(AccountLink data) => json.encode(data.toJson());

class AccountLink {
  AccountLink({
    this.object,
    this.created,
    this.expiresAt,
    this.url,
  });

  String? object;
  int? created;
  int? expiresAt;
  String? url;

  factory AccountLink.fromJson(Map<String, dynamic> json) => AccountLink(
        object: json["object"],
        created: json["created"] ?? "",
        expiresAt: json["expires_at"] ?? "",
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "expires_at": expiresAt,
        "url": url,
      };
}
