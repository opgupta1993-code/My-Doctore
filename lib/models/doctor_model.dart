import 'package:flutter_hello_my_doctor/utils/utils.dart';

class DoctorModel {
  DoctorDetailsModel _doctorDetails = DoctorDetailsModel();
  RatingModel _rating = RatingModel();
  final List<ReviewModel> _reviewsList = <ReviewModel>[];
  double _overallRating = 0.0;

  DoctorModel.fromJson(Map json) {
    if (json.containsKey("doctor_details") && json["doctor_details"] is Map) {
      _doctorDetails = DoctorDetailsModel.fromJson(json["doctor_details"]);
    }

    if (json.containsKey("rating_count_and_percent") &&
        json["rating_count_and_percent"] is Map) {
      _rating = RatingModel.fromJson(json["rating_count_and_percent"]);
    }

    if (json.containsKey("doctor_reviews") && json["doctor_reviews"] is List) {
      for (Map d in json["doctor_reviews"]) {
        _reviewsList.add(ReviewModel.fromJson(d));
      }
    }

    _overallRating = Utils.getDoubleFromString("${json["doctor_avg_rating"]}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_details'] = _doctorDetails;
    data['rating_count_and_percent'] = _rating;
    data['doctor_avg_rating'] = _overallRating;
    return data;
  }

  DoctorDetailsModel get doctorDetails => _doctorDetails;
  RatingModel get rating => _rating;
  List<ReviewModel> get reviewsList => _reviewsList;
  double get overallRating => _overallRating;
}

class DoctorDetailsModel {
  String _id = "";
  String _categoryId = "";
  String _locationId = "";
  String _hospitalName = "";
  String _name = "";
  String _degree = "";
  String _startExperience = "";
  String _fromTime = "";
  String _toTime = "";
  String _days = "";
  String _fromDay = "";
  String _toDay = "";
  String _fees = "";
  String _address = "";
  String _dob = "";
  String _anniversary = "";
  String _contact = "";
  String _password = "";
  String _image = "";
  String _viewStatus = "";
  String _status = "";
  String _entryDate = "";
  String _registrationNo = "";
  String _oldPrescriptionValid = "";
  String _adminApproval = "";
  double _rating = 0.0;
  String _locationName = "";
  String _categoryName = "";
  String _description = "";
  bool _isDoctorOnLeave = false;
  String _fromDate = "";
  String _toDate = "";
  bool _isRated = false;
  String _ratingDes = "";
  bool _isBookingChargesApplied = false;
  String _revisitDays = "";

  DoctorDetailsModel();

  DoctorDetailsModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _categoryId = json['category_id'] ?? "";
    _locationId = json['location_id'] ?? "";
    _hospitalName = json['hospital_name'] ?? "";
    _name = json['name'] ?? "";
    _degree = json['degree'] ?? "";
    _startExperience = json['start_experience'] ?? "";
    _fromTime = json['from_time'] ?? "";
    _toTime = json['to_time'] ?? "";
    _days = json['days'] ?? "";
    _fromDay = json['from_day'] ?? "";
    _toDay = json['to_day'] ?? "";
    _fees = json['fees'] ?? "";
    _address = json['address'] ?? "";
    _dob = json['dob'] ?? "";
    _anniversary = json['anniversary'] ?? "";
    _contact = json['contact'] ?? "";
    _password = json['password'] ?? "";
    _image = json['image'] ?? "";
    _viewStatus = json['view_status'] ?? "";
    _status = json['status'] ?? "";
    _entryDate = json['entry_date'] ?? "";
    _registrationNo = json['registration_no'] ?? "";
    _oldPrescriptionValid = json['old_prescription_valid'] ?? "";
    _adminApproval = json['admin_approval'] ?? "";
    _rating = Utils.getDoubleFromString("${json['rating']}");
    _locationName = json['location_name'] ?? "";
    _categoryName = json['category_name'] ?? "";
    _description = json['description'] ?? "";
    _isDoctorOnLeave = json['is_doctor_on_leave'] == 1;
    _fromDate = json['from_date'] ?? "";
    _toDate = json['to_date'] ?? "";
    _isRated = json['is_rated'] == 1;
    _ratingDes = json['rating_des'] ?? "";
    _isBookingChargesApplied = json["fees_booking_charges"] == "1";
    _revisitDays = json["revisit_days"] ?? "";
  }

  String getNextAvailability(String inputDay) {
    final List<String> days = this.days.split(",");

    if (days.contains(inputDay)) {
      return "Tomorrow";
    } else {
      final int currentIndex =
          days.indexWhere((day) => day.compareTo(inputDay) > 0);
      if (currentIndex == -1) {
        // When inputDay is greater than all elements in the list
        return days.first;
      } else {
        return days[currentIndex];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['category_id'] = _categoryId;
    data['location_id'] = _locationId;
    data['hospital_name'] = _hospitalName;
    data['name'] = _name;
    data['degree'] = _degree;
    data['start_experience'] = _startExperience;
    data['from_time'] = _fromTime;
    data['to_time'] = _toTime;
    data['days'] = _days;
    data['from_day'] = _fromDay;
    data['to_day'] = _toDay;
    data['fees'] = _fees;
    data['address'] = _address;
    data['dob'] = _dob;
    data['anniversary'] = _anniversary;
    data['contact'] = _contact;
    data['password'] = _password;
    data['image'] = _image;
    data['view_status'] = _viewStatus;
    data['status'] = _status;
    data['entry_date'] = _entryDate;
    data['registration_no'] = _registrationNo;
    data['old_prescription_valid'] = _oldPrescriptionValid;
    data['admin_approval'] = _adminApproval;
    data['rating'] = _rating;
    data['location_name'] = _locationName;
    data['category_name'] = _categoryName;
    data['description'] = _description;
    data['is_doctor_on_leave'] = _isDoctorOnLeave ? 1 : 0;
    data['from_date'] = _fromDate;
    data['to_date'] = _toDate;
    data['is_rated'] = _isRated;
    data['rating_des'] = _ratingDes;
    data["fees_booking_charges"] = _isBookingChargesApplied ? "1" : "0";
    data["revisit_days"] = _revisitDays;
    return data;
  }

  String get id => _id;
  String get categoryId => _categoryId;
  String get locationId => _locationId;
  String get hospitalName => _hospitalName;
  String get name => _name;
  String get degree => _degree;
  String get startExperience => _startExperience;
  String get fromTime => _fromTime;
  String get toTime => _toTime;
  String get days => _days;
  String get fromDay => _fromDay;
  String get toDay => _toDay;
  String get fees => _fees;
  String get address => _address;
  String get dob => _dob;
  String get anniversary => _anniversary;
  String get contact => _contact;
  String get password => _password;
  String get image => _image;
  String get viewStatus => _viewStatus;
  String get status => _status;
  String get entryDate => _entryDate;
  String get registrationNo => _registrationNo;
  String get oldPrescriptionValid => _oldPrescriptionValid;
  String get adminApproval => _adminApproval;
  double get rating => _rating;
  String get locationName => _locationName;
  String get categoryName => _categoryName;
  String get description => _description;
  bool get isDoctorOnLeave => _isDoctorOnLeave;
  String get fromDate => _fromDate;
  String get toDate => _toDate;
  bool get isRated => _isRated;
  String get ratingDes => _ratingDes;
  bool get isBookingChargesApplied => _isBookingChargesApplied;
  String get revisitDays => _revisitDays;
}

// class MyRatingInfoModel {
//   bool _isDoctorRated = false;
//   double _howManyRated = 0.0;
//   String _description = "";

//   MyRatingInfoModel();

//   MyRatingInfoModel.fromJson(Map<String, dynamic> json) {
//     _isDoctorRated = json['is_doctor_rated'] == 1;
//     _howManyRated = Utils.getDoubleFromString("${json['how_many_rated']}");
//     _description = json['msg'] ?? "";
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['is_doctor_rated'] = _isDoctorRated;
//     data['how_many_rated'] = _howManyRated;
//     data['msg'] = _description;
//     return data;
//   }

//   bool get isDoctorRated => _isDoctorRated;
//   double get howManyRated => _howManyRated;
//   String get description => _description;
// }

class RatingModel {
  int _noOfRating1 = 0;
  double _d1RatingPercent = 0.0;
  int _noOfRating2 = 0;
  double _d2RatingPercent = 0.0;
  int _noOfRating3 = 0;
  double _d3RatingPercent = 0.0;
  int _noOfRating4 = 0;
  double _d4RatingPercent = 0.0;
  int _noOfRating5 = 0;
  double _d5RatingPercent = 0.0;

  RatingModel();

  RatingModel.fromJson(Map<String, dynamic> json) {
    _noOfRating1 = Utils.getIntFromString("${json['no_of_rating_1']}");
    _d1RatingPercent = Utils.getDoubleFromString("${json['1_rating_percent']}");
    _noOfRating2 = Utils.getIntFromString("${json['no_of_rating_2']}");
    _d2RatingPercent = Utils.getDoubleFromString("${json['2_rating_percent']}");
    _noOfRating3 = Utils.getIntFromString("${json['no_of_rating_3']}");
    _d3RatingPercent = Utils.getDoubleFromString("${json['3_rating_percent']}");
    _noOfRating4 = Utils.getIntFromString("${json['no_of_rating_4']}");
    _d4RatingPercent = Utils.getDoubleFromString("${json['4_rating_percent']}");
    _noOfRating5 = Utils.getIntFromString("${json['']}");
    _d5RatingPercent = Utils.getDoubleFromString("${json['5_rating_percent']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_of_rating_1'] = _noOfRating1;
    data['1_rating_percent'] = _d1RatingPercent;
    data['no_of_rating_2'] = _noOfRating2;
    data['2_rating_percent'] = _d2RatingPercent;
    data['no_of_rating_3'] = _noOfRating3;
    data['3_rating_percent'] = _d3RatingPercent;
    data['no_of_rating_4'] = _noOfRating4;
    data['4_rating_percent'] = _d4RatingPercent;
    data['no_of_rating_5'] = _noOfRating5;
    data['5_rating_percent'] = _d5RatingPercent;
    return data;
  }

  int get noOfRating1 => _noOfRating1;
  double get d1RatingPercent => _d1RatingPercent;
  int get noOfRating2 => _noOfRating2;
  double get d2RatingPercent => _d2RatingPercent;
  int get noOfRating3 => _noOfRating3;
  double get d3RatingPercent => _d3RatingPercent;
  int get noOfRating4 => _noOfRating4;
  double get d4RatingPercent => _d4RatingPercent;
  int get noOfRating5 => _noOfRating5;
  double get d5RatingPercent => _d5RatingPercent;
}

class ReviewModel {
  String _id = "";
  String _userId = "";
  String _doctorId = "";
  double _rating = 0.0;
  String _description = "";
  String _date = "";
  String _dateTime = "";
  String _userImg = "";
  String _userName = "";

  ReviewModel.fromJson(Map json) {
    _id = json['id'] ?? "";
    _userId = json['user_id'] ?? "";
    _doctorId = json['doctor_id'] ?? "";
    _rating = Utils.getDoubleFromString("${json['rating']}");
    _description = json['description'] ?? "";
    _date = json['date'] ?? "";
    _dateTime = json['date_time'] ?? "";
    _userImg = json['user_img'] ?? "";
    _userName = json['user_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['doctor_id'] = _doctorId;
    data['rating'] = _rating;
    data['description'] = _description;
    data['date'] = _date;
    data['date_time'] = _dateTime;
    data['user_img'] = _userImg;
    data['user_name'] = _userName;
    return data;
  }

  String get id => _id;
  String get userId => _userId;
  String get doctorId => _doctorId;
  double get rating => _rating;
  String get description => _description;
  String get date => _date;
  String get dateTime => _dateTime;
  String get userImg => _userImg;
  String get userName => _userName;
}
