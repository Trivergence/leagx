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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['push_token'] = this.pushToken;
    data['is_active'] = this.isActive;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}