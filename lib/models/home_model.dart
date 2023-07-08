import 'package:flutter_hello_my_doctor/models/doctor_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeModel {
  late final List<SliderModel> _sliders;
  late final List<DoctorDetailsModel> _doctors;
  late final List<VideoReviewModel> _doctorsReview;
  late final List<VideoReviewModel> _customersReview;
  late final ServiceServedModel _serviceServed;

  HomeModel() {
    _sliders = <SliderModel>[];
    _doctors = <DoctorDetailsModel>[];
    _doctorsReview = <VideoReviewModel>[];
    _customersReview = <VideoReviewModel>[];
    _serviceServed = ServiceServedModel();
  }

  HomeModel.fromJson(Map json) {
    _sliders = <SliderModel>[];
    _doctors = <DoctorDetailsModel>[];
    _doctorsReview = <VideoReviewModel>[];
    _customersReview = <VideoReviewModel>[];

    if (json['service_served'] != null && json['service_served'] is Map) {
      _serviceServed = ServiceServedModel.fromJson(json['service_served']);
    } else {
      _serviceServed = ServiceServedModel();
    }

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
  ServiceServedModel get serviceServed => _serviceServed;
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
  String _videoId = "";

  VideoReviewModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _title = json['title'] ?? "";
    _videoType = json['video_type'] ?? "";
    _video = json['video'] ?? "";
    _desc = json['desc'] ?? "";
    _status = json['status'] ?? "";

    _videoId = YoutubePlayer.convertUrlToId(_video) ?? "";
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
  String get videoId => _videoId;
}

class ServiceServedModel {
  String _id = "";
  String _clientRetention = "0";
  String _yearsOfService = "0";
  String _teamOfProfessionals = "0";
  String _satisfiedClient = "0";
  String _status = "";

  ServiceServedModel();

  ServiceServedModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _clientRetention = json['client_retention'] ?? "";
    _yearsOfService = json['years_of_service'] ?? "";
    _teamOfProfessionals = json['team_of_professionals'] ?? "";
    _satisfiedClient = json['satisfied_client'] ?? "";
    _status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['client_retention'] = _clientRetention;
    data['years_of_service'] = _yearsOfService;
    data['team_of_professionals'] = _teamOfProfessionals;
    data['satisfied_client'] = _satisfiedClient;
    data['status'] = _status;
    return data;
  }

  String get id => _id;
  String get clientRetention => _clientRetention;
  String get yearsOfService => _yearsOfService;
  String get teamOfProfessionals => _teamOfProfessionals;
  String get satisfiedClient => _satisfiedClient;
  String get status => _status;
}
