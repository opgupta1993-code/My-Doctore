class UserModel {
  String _userId = "";
  String _userName = "";
  String _mobileNo = "";
  String _socialType = "";
  String _socialId = "";
  String _deviceId = "";
  String _userImg = "";
  String _status = "";
  String _entryDate = "";
  String _updateDate = "";
  String _address = "";
  String _dob = "";

  UserModel();

  UserModel.fromJson(Map json) {
    _userId = json['user_id'] ?? "";
    _userName = json['user_name'] ?? "";
    _mobileNo = json['mobile_no'] ?? "";
    _socialType = json['social_type'] ?? "";
    _socialId = json['social_id'] ?? "";
    _deviceId = json['device_id'] ?? "";
    _userImg = json['user_img'] ?? "";
    _status = json['status'] ?? "";
    _entryDate = json['entry_date'] ?? "";
    _updateDate = json['update_date'] ?? "";
    _address = json['address'] ?? "";
    _dob = json['dob'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = _userId;
    data['user_name'] = _userName;
    data['mobile_no'] = _mobileNo;
    data['social_type'] = _socialType;
    data['social_id'] = _socialId;
    data['device_id'] = _deviceId;
    data['user_img'] = _userImg;
    data['status'] = _status;
    data['entry_date'] = _entryDate;
    data['update_date'] = _updateDate;
    data['address'] = _address;
    data['dob'] = _dob;
    return data;
  }

  String get userId => _userId;
  String get userName => _userName;
  String get mobileNo => _mobileNo;
  String get socialType => _socialType;
  String get socialId => _socialId;
  String get deviceId => _deviceId;
  String get userImg => _userImg;
  String get status => _status;
  String get entryDate => _entryDate;
  String get updateDate => _updateDate;
  String get address => _address;
  String get dob => _dob;
}
