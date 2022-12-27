class ErrorModel {
  ErrorModel({
    this.error,
    this.errorLog,
  });

  ErrorModel.fromJson(dynamic json) {
    error = json['error'];
    errorLog =
        json['error_log'] != null ? json['error_log'].cast<String>() : [];
  }
  String? error;
  List<String>? errorLog;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['error_log'] = errorLog;
    return map;
  }
}
