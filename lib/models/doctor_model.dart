class DoctorModel {
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

  DoctorModel.fromJson(Map json) {
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
  }

  String getNextAvailability(String inputDay) {
    final List<String> days = this.days.split(",");
    // const List<String> days=["Tuesday","Wednesday","Thursday","Saturday"];


    print("DAYS --> ${days}");

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
}
