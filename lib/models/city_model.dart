class CityModel {
  String _id = "";
  String _name = "";
  String _image = "";
  String _status = "";

  CityModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _name = json['name'] ?? "";
    _image = json['image'] ?? "";
    _status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    data['status'] = _status;
    return data;
  }

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get status => _status;
}
