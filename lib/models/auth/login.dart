class Login {
  Login({
      this.id, 
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
      this.uid,});

  Login.fromJson(dynamic json) {
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
  int? id;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? phone;
  dynamic gender;
  String? address;
  String? apiToken;
  dynamic role;
  dynamic dob;
  dynamic profileImg;
  dynamic coverImg;
  dynamic provider;
  dynamic uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['gender'] = gender;
    map['address'] = address;
    map['api_token'] = apiToken;
    map['role'] = role;
    map['dob'] = dob;
    map['profile_img'] = profileImg;
    map['cover_img'] = coverImg;
    map['provider'] = provider;
    map['uid'] = uid;
    return map;
  }

}