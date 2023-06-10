import 'package:flutter_hello_my_doctor/models/doctor_model.dart';

class HomeModel {
  late final List<SliderModel> _sliders;
  late final List<DoctorModel> _doctors;

  HomeModel() {
    _sliders = <SliderModel>[];
    _doctors = <DoctorModel>[];
  }

  HomeModel.fromJson(Map json) {
    _sliders = <SliderModel>[];
    _doctors = <DoctorModel>[];

    if (json['sliders'] != null && json['sliders'] is List) {
      json['sliders'].forEach((v) {
        _sliders.add(SliderModel.fromJson(v));
      });
    }

    if (json['doctors'] != null && json['doctors'] is List) {
      json['doctors'].forEach((v) {
        _doctors.add(DoctorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sliders'] = _sliders.map((v) => v.toJson()).toList();
    data['doctors'] = _doctors.map((v) => v.toJson()).toList();
    return data;
  }

  List<SliderModel> get sliders => _sliders;
  List<DoctorModel> get doctors => _doctors;
}

class SliderModel {
  String _id = "";
  String _title = "";
  String _image = "";
  String _desc = "";

  SliderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'] ?? "";
    _title = json['title'] ?? "";
    _image = json['image'] ?? "";
    _desc = json['desc'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['image'] = _image;
    data['desc'] = _desc;
    return data;
  }

  String get id => _id;
  String get title => _title;
  String get image => _image;
  String get desc => _desc;
}
