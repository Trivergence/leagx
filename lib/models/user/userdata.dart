import 'package:leagx/models/user/user_device.dart';

class UserData {
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  dynamic phone;
  String? gender;
  String? address;
  String? apiToken;
  String? role;
  String? dob;
  String? profileImg;
  String? coverImg;
  String? provider;
  String? uid;
  List<UserDevice>? userDevices;

  UserData(
      {this.id,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.phone,
      this.gender,
      this.address,
      this.apiToken,
      this.role,
      this.dob,
      this.profileImg,
      this.coverImg,
      this.provider,
      this.uid,
      this.userDevices});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    gender = json['gender'];
    address = json['address'];
    apiToken = json['api_token'];
    role = json['role'];
    dob = json['dob'];
    profileImg = json['profile_img'];
    coverImg = json['cover_img'];
    provider = json['provider'];
    uid = json['uid'];
    if (json['user_devices'] != null) {
      userDevices = <UserDevice>[];
      json['user_devices'].forEach((v) {
        userDevices!.add( UserDevice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['gender'] = gender;
    data['address'] = address;
    data['api_token'] = apiToken;
    data['role'] = role;
    data['dob'] = dob;
    data['profile_img'] = profileImg;
    data['cover_img'] = coverImg;
    data['provider'] = provider;
    data['uid'] = uid;
    if (userDevices != null) {
      data['user_devices'] = userDevices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
