class User {
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

  User(
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
      this.uid});

  User.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['api_token'] = this.apiToken;
    data['role'] = this.role;
    data['dob'] = this.dob;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['provider'] = this.provider;
    data['uid'] = this.uid;
    return data;
  }
}
