//@dart=2.9

class GetAllDoctorsArticles {
  List<GetAllDoctorsArticlesData> _data;
  bool _status;
  int _success;
  String _message;

  List<GetAllDoctorsArticlesData> get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetAllDoctorsArticles({
      List<GetAllDoctorsArticlesData> data,
      bool status, 
      int success, 
      String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAllDoctorsArticles.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(GetAllDoctorsArticlesData.fromJson(v));
      });
    }
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}

class GetAllDoctorsArticlesData {
  int _id;
  int _doctorId;
  String _title;
  String _image;
  String _description;
  String _createdAt;
  String _updatedAt;
  Doctor _doctor;

  int get id => _id;
  int get doctorId => _doctorId;
  String get title => _title;
  String get image => _image;
  String get description => _description;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Doctor get doctor => _doctor;

  GetAllDoctorsArticlesData({
      int id, 
      int doctorId, 
      String title, 
      String image, 
      String description, 
      String createdAt, 
      String updatedAt, 
      Doctor doctor}){
    _id = id;
    _doctorId = doctorId;
    _title = title;
    _image = image;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _doctor = doctor;
}

  GetAllDoctorsArticlesData.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _title = json["title"];
    _image = json["image"];
    _description = json["description"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _doctor = json["doctor"] != null ? Doctor.fromJson(json["doctor"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["title"] = _title;
    map["image"] = _image;
    map["description"] = _description;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_doctor != null) {
      map["doctor"] = _doctor.toJson();
    }
    return map;
  }

}


class Doctor {
  int _id;
  String _name;
  String _username;
  String _email;
  String _mobile;
  int _otpIsVerified;
  dynamic _refBy;
  String _balance;
  String _image;
  String _address;
  dynamic _lat;
  dynamic _long;
  int _sectorId;
  int _locationId;
  String _qualification;
  int _rating;
  int _status;
  int _ev;
  int _sv;
  dynamic _verCode;
  dynamic _verCodeSendAt;
  int _ts;
  int _tv;
  dynamic _tsc;
  int _fees;
  int _slotType;
  String _startTime;
  String _endTime;
  int _serialDay;
  List<Serial_day_app> _serialDayApp;
  int _maxSerial;
  int _duration;
  List<String> _serialOrSlot;
  String _about;
  int _featured;
  List<String> _speciality;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get name => _name;
  String get username => _username;
  String get email => _email;
  String get mobile => _mobile;
  int get otpIsVerified => _otpIsVerified;
  dynamic get refBy => _refBy;
  String get balance => _balance;
  String get image => _image;
  String get address => _address;
  dynamic get lat => _lat;
  dynamic get long => _long;
  int get sectorId => _sectorId;
  int get locationId => _locationId;
  String get qualification => _qualification;
  int get rating => _rating;
  int get status => _status;
  int get ev => _ev;
  int get sv => _sv;
  dynamic get verCode => _verCode;
  dynamic get verCodeSendAt => _verCodeSendAt;
  int get ts => _ts;
  int get tv => _tv;
  dynamic get tsc => _tsc;
  int get fees => _fees;
  int get slotType => _slotType;
  String get startTime => _startTime;
  String get endTime => _endTime;
  int get serialDay => _serialDay;
  List<Serial_day_app> get serialDayApp => _serialDayApp;
  int get maxSerial => _maxSerial;
  int get duration => _duration;
  List<String> get serialOrSlot => _serialOrSlot;
  String get about => _about;
  int get featured => _featured;
  List<String> get speciality => _speciality;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Doctor({
      int id, 
      String name, 
      String username, 
      String email, 
      String mobile, 
      int otpIsVerified, 
      dynamic refBy, 
      String balance, 
      String image, 
      String address, 
      dynamic lat, 
      dynamic long, 
      int sectorId, 
      int locationId, 
      String qualification, 
      int rating, 
      int status, 
      int ev, 
      int sv, 
      dynamic verCode, 
      dynamic verCodeSendAt, 
      int ts, 
      int tv, 
      dynamic tsc, 
      int fees, 
      int slotType, 
      String startTime, 
      String endTime, 
      int serialDay, 
      List<Serial_day_app> serialDayApp, 
      int maxSerial, 
      int duration, 
      List<String> serialOrSlot, 
      String about, 
      int featured, 
      List<String> speciality, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _mobile = mobile;
    _otpIsVerified = otpIsVerified;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _address = address;
    _lat = lat;
    _long = long;
    _sectorId = sectorId;
    _locationId = locationId;
    _qualification = qualification;
    _rating = rating;
    _status = status;
    _ev = ev;
    _sv = sv;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _fees = fees;
    _slotType = slotType;
    _startTime = startTime;
    _endTime = endTime;
    _serialDay = serialDay;
    _serialDayApp = serialDayApp;
    _maxSerial = maxSerial;
    _duration = duration;
    _serialOrSlot = serialOrSlot;
    _about = about;
    _featured = featured;
    _speciality = speciality;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Doctor.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _username = json["username"];
    _email = json["email"];
    _mobile = json["mobile"];
    _otpIsVerified = json["otp_is_verified"];
    _refBy = json["ref_by"];
    _balance = json["balance"];
    _image = json["image"];
    _address = json["address"];
    _lat = json["lat"];
    _long = json["long"];
    _sectorId = json["sector_id"];
    _locationId = json["location_id"];
    _qualification = json["qualification"];
    _rating = json["rating"];
    _status = json["status"];
    _ev = json["ev"];
    _sv = json["sv"];
    _verCode = json["ver_code"];
    _verCodeSendAt = json["ver_code_send_at"];
    _ts = json["ts"];
    _tv = json["tv"];
    _tsc = json["tsc"];
    _fees = json["fees"];
    _slotType = json["slot_type"];
    _startTime = json["start_time"];
    _endTime = json["end_time"];
    _serialDay = json["serial_day"];
    if (json["serial_day_app"] != null) {
      _serialDayApp = [];
      json["serial_day_app"].forEach((v) {
        _serialDayApp.add(Serial_day_app.fromJson(v));
      });
    }
    _maxSerial = json["max_serial"];
    _duration = json["duration"];
    _serialOrSlot = json["serial_or_slot"] != null ? json["serial_or_slot"].cast<String>() : [];
    _about = json["about"];
    _featured = json["featured"];
    _speciality = json["speciality"] != null ? json["speciality"].cast<String>() : [];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["username"] = _username;
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["otp_is_verified"] = _otpIsVerified;
    map["ref_by"] = _refBy;
    map["balance"] = _balance;
    map["image"] = _image;
    map["address"] = _address;
    map["lat"] = _lat;
    map["long"] = _long;
    map["sector_id"] = _sectorId;
    map["location_id"] = _locationId;
    map["qualification"] = _qualification;
    map["rating"] = _rating;
    map["status"] = _status;
    map["ev"] = _ev;
    map["sv"] = _sv;
    map["ver_code"] = _verCode;
    map["ver_code_send_at"] = _verCodeSendAt;
    map["ts"] = _ts;
    map["tv"] = _tv;
    map["tsc"] = _tsc;
    map["fees"] = _fees;
    map["slot_type"] = _slotType;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["serial_day"] = _serialDay;
    if (_serialDayApp != null) {
      map["serial_day_app"] = _serialDayApp.map((v) => v.toJson()).toList();
    }
    map["max_serial"] = _maxSerial;
    map["duration"] = _duration;
    map["serial_or_slot"] = _serialOrSlot;
    map["about"] = _about;
    map["featured"] = _featured;
    map["speciality"] = _speciality;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}

/// days : ["Monday","Tuesday"]
/// slots : ["8:00 PM","8:30 PM","9:00 PM","9:30 PM"]
/// duration : "30"
/// end_time : "22:00"
/// start_time : "20:00"
/// clinic_name : "Online"
/// schedule_type : "Online"
/// clinic_address : null

class Serial_day_app {
  List<String> _days;
  List<String> _slots;
  String _duration;
  String _endTime;
  String _startTime;
  String _clinicName;
  String _scheduleType;
  dynamic _clinicAddress;

  List<String> get days => _days;
  List<String> get slots => _slots;
  String get duration => _duration;
  String get endTime => _endTime;
  String get startTime => _startTime;
  String get clinicName => _clinicName;
  String get scheduleType => _scheduleType;
  dynamic get clinicAddress => _clinicAddress;

  Serial_day_app({
      List<String> days, 
      List<String> slots, 
      String duration, 
      String endTime, 
      String startTime, 
      String clinicName, 
      String scheduleType, 
      dynamic clinicAddress}){
    _days = days;
    _slots = slots;
    _duration = duration;
    _endTime = endTime;
    _startTime = startTime;
    _clinicName = clinicName;
    _scheduleType = scheduleType;
    _clinicAddress = clinicAddress;
}

  Serial_day_app.fromJson(dynamic json) {
    _days = json["days"] != null ? json["days"].cast<String>() : [];
    _slots = json["slots"] != null ? json["slots"].cast<String>() : [];
    _duration = json["duration"];
    _endTime = json["end_time"];
    _startTime = json["start_time"];
    _clinicName = json["clinic_name"];
    _scheduleType = json["schedule_type"];
    _clinicAddress = json["clinic_address"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["days"] = _days;
    map["slots"] = _slots;
    map["duration"] = _duration;
    map["end_time"] = _endTime;
    map["start_time"] = _startTime;
    map["clinic_name"] = _clinicName;
    map["schedule_type"] = _scheduleType;
    map["clinic_address"] = _clinicAddress;
    return map;
  }

}