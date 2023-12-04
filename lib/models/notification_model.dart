class NotificationModel {
  String _id = "";
  String _userId = "";
  String _doctorId = "";
  String _type = "";
  String _title = "";
  String _notificationType = "";
  String _notification = "";
  String _dateTime = "";
  String _userName = "";
  String _doctorName = "";

  String get id => _id;
  String get userId => _userId;
  String get doctorId => _doctorId;
  String get type => _type;
  String get title => _title;
  String get notificationType => _notificationType;
  String get notification => _notification;
  String get dateTime => _dateTime;
  String get userName => _userName;
  String get doctorName => _doctorName;

  NotificationModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _userId = json['user_id'] ?? "";
    _doctorId = json['doctor_id'] ?? "";
    _type = json['type'] ?? "";
    _title = json['title'] ?? "";
    _notificationType = json['notification_type'] ?? "";
    _notification = json['notification'] ?? "";
    _dateTime = json['date_time'] ?? "";
    _userName = json['user_name'] ?? "";
    _doctorName = json['doctor_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['doctor_id'] = _doctorId;
    data['type'] = _type;
    data['title'] = _title;
    data['notification_type'] = _notificationType;
    data['notification'] = _notification;
    data['date_time'] = _dateTime;
    data['user_name'] = _userName;
    data['doctor_name'] = _doctorName;
    return data;
  }
}
