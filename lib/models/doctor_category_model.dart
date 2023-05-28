class DoctorCategoryModel {
  String _id = "";
  String _categoryName = "";
  String _image = "";
  String _status = "";

  DoctorCategoryModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _categoryName = json['category_name'] ?? "";
    _image = json['image'] ?? "";
    _status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['category_name'] = _categoryName;
    data['image'] = _image;
    data['status'] = _status;
    return data;
  }

  String get id => _id;
  String get categoryName => _categoryName;
  String get image => _image;
  String get status => _status;
}
