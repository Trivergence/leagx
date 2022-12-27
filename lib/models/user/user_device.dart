class UserDevice {
  int? id;
  String? pushToken;
  bool? isActive;
  int? userId;
  String? createdAt;
  String? updatedAt;

  UserDevice(
      {this.id,
      this.pushToken,
      this.isActive,
      this.userId,
      this.createdAt,
      this.updatedAt});

  UserDevice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pushToken = json['push_token'];
    isActive = json['is_active'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['push_token'] = pushToken;
    data['is_active'] = isActive;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}