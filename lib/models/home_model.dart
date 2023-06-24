import 'package:flutter_hello_my_doctor/models/doctor_model.dart';

class HomeModel {
  late final List<SliderModel> _sliders;
  late final List<DoctorDetailsModel> _doctors;
  late final List<VideoReviewModel> _doctorsReview;
  late final List<VideoReviewModel> _customersReview;

  HomeModel() {
    _sliders = <SliderModel>[];
    _doctors = <DoctorDetailsModel>[];
    _doctorsReview = <VideoReviewModel>[];
    _customersReview = <VideoReviewModel>[];
  }

  HomeModel.fromJson(Map json) {
    _sliders = <SliderModel>[];
    _doctors = <DoctorDetailsModel>[];
    _doctorsReview = <VideoReviewModel>[];
    _customersReview = <VideoReviewModel>[];

    if (json['sliders'] != null && json['sliders'] is List) {
      json['sliders'].forEach((v) {
        _sliders.add(SliderModel.fromJson(v));
      });
    }

    if (json['doctors'] != null && json['doctors'] is List) {
      json['doctors'].forEach((v) {
        _doctors.add(DoctorDetailsModel.fromJson(v));
      });
    }

    if (json['doctor_video'] != null && json['doctor_video'] is List) {
      json['doctor_video'].forEach((v) {
        _doctorsReview.add(VideoReviewModel.fromJson(v));
      });
    }

    if (json['customer_video'] != null && json['customer_video'] is List) {
      json['customer_video'].forEach((v) {
        _customersReview.add(VideoReviewModel.fromJson(v));
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
  List<DoctorDetailsModel> get doctors => _doctors;
  List<VideoReviewModel> get doctorsReview => _doctorsReview;
  List<VideoReviewModel> get customersReview => _customersReview;
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

class VideoReviewModel {
  String _id = "";
  String _title = "";
  String _videoType = "";
  String _video = "";
  String _desc = "";
  String _status = "";

  VideoReviewModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _title = json['title'] ?? "";
    _videoType = json['video_type'] ?? "";
    _video = json['video'] ?? "";
    _desc = json['desc'] ?? "";
    _status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['video_type'] = _videoType;
    data['video'] = _video;
    data['desc'] = _desc;
    data['status'] = _status;
    return data;
  }

  String get id => _id;
  String get title => _title;
  String get videoType => _videoType;
  String get video => _video;
  String get desc => _desc;
  String get status => _status;
}
