//@dart=2.9

class GetDoctorProfileModal {
  GetDoctorProfileModalData _data;
  bool _status;
  int _success;
  String _message;

  GetDoctorProfileModalData get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetDoctorProfileModal({
    GetDoctorProfileModalData data,
    bool status,
    int success,
    String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetDoctorProfileModal.fromJson(dynamic json) {
    _data = json["data"] != null ? GetDoctorProfileModalData.fromJson(json["data"]) : null;
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}


class GetDoctorProfileModalData {
  int _id;
  String _name;
  dynamic _username;
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
  int _maxSerial;
  int _duration;
  List<String> _serialOrSlot;
  String _about;
  int _featured;
  List<String> _speciality;
  String _createdAt;
  String _updatedAt;
  List<Schedules> _schedules;
  List<Clinics> _clinics;
  String _imagePath;
  List<Education_details> _educationDetails;
  List<Experience_details> _experienceDetails;
  List<Appointments> _appointments;

  int get id => _id;
  String get name => _name;
  dynamic get username => _username;
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
  int get maxSerial => _maxSerial;
  int get duration => _duration;
  List<String> get serialOrSlot => _serialOrSlot;
  String get about => _about;
  int get featured => _featured;
  List<String> get speciality => _speciality;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<Schedules> get schedules => _schedules;
  List<Clinics> get clinics => _clinics;
  String get imagePath => _imagePath;
  List<Education_details> get educationDetails => _educationDetails;
  List<Experience_details> get experienceDetails => _experienceDetails;
  List<Appointments> get appointments => _appointments;

  GetDoctorProfileModalData({
    int id,
    String name,
    dynamic username,
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
    int maxSerial,
    int duration,
    List<String> serialOrSlot,
    String about,
    int featured,
    List<String> speciality,
    String createdAt,
    String updatedAt,
    List<Schedules> schedules,
    List<Clinics> clinics,
    String imagePath,
    List<Education_details> educationDetails,
    List<Experience_details> experienceDetails,
    List<Appointments> appointments}){
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
    _maxSerial = maxSerial;
    _duration = duration;
    _serialOrSlot = serialOrSlot;
    _about = about;
    _featured = featured;
    _speciality = speciality;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _schedules = schedules;
    _clinics = clinics;
    _imagePath = imagePath;
    _educationDetails = educationDetails;
    _experienceDetails = experienceDetails;
    _appointments = appointments;
  }

  GetDoctorProfileModalData.fromJson(dynamic json) {
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
    _maxSerial = json["max_serial"];
    _duration = json["duration"];
    _serialOrSlot = json["serial_or_slot"] != null ? json["serial_or_slot"].cast<String>() : [];
    _about = json["about"];
    _featured = json["featured"];
    _speciality = json["speciality"] != null ? json["speciality"].cast<String>() : [];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    if (json["schedules"] != null) {
      _schedules = [];
      json["schedules"].forEach((v) {
        _schedules.add(Schedules.fromJson(v));
      });
    }
    if (json["clinics"] != null) {
      _clinics = [];
      json["clinics"].forEach((v) {
        _clinics.add(Clinics.fromJson(v));
      });
    }
    _imagePath = json["image_path"];
    if (json["education_details"] != null) {
      _educationDetails = [];
      json["education_details"].forEach((v) {
        _educationDetails.add(Education_details.fromJson(v));
      });
    }
    if (json["experience_details"] != null) {
      _experienceDetails = [];
      json["experience_details"].forEach((v) {
        _experienceDetails.add(Experience_details.fromJson(v));
      });
    }
    if (json["appointments"] != null) {
      _appointments = [];
      json["appointments"].forEach((v) {
        _appointments.add(Appointments.fromJson(v));
      });
    }
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
    map["max_serial"] = _maxSerial;
    map["duration"] = _duration;
    map["serial_or_slot"] = _serialOrSlot;
    map["about"] = _about;
    map["featured"] = _featured;
    map["speciality"] = _speciality;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_schedules != null) {
      map["schedules"] = _schedules.map((v) => v.toJson()).toList();
    }
    if (_clinics != null) {
      map["clinics"] = _clinics.map((v) => v.toJson()).toList();
    }
    map["image_path"] = _imagePath;
    if (_educationDetails != null) {
      map["education_details"] = _educationDetails.map((v) => v.toJson()).toList();
    }
    if (_experienceDetails != null) {
      map["experience_details"] = _experienceDetails.map((v) => v.toJson()).toList();
    }
    if (_appointments != null) {
      map["appointments"] = _appointments.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Appointments {
  int _id;
  int _doctorId;
  dynamic _customerId;
  dynamic _entryDoctor;
  dynamic _assistant;
  dynamic _staff;
  int _admin;
  int _site;
  String _name;
  String _email;
  String _mobile;
  int _age;
  dynamic _disease;
  String _bookingDate;
  String _timeSerial;
  int _pStatus;
  dynamic _trx;
  int _isComplete;
  int _dStatus;
  int _dDoctor;
  dynamic _dAssistant;
  dynamic _dStaff;
  int _dAdmin;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  dynamic get customerId => _customerId;
  dynamic get entryDoctor => _entryDoctor;
  dynamic get assistant => _assistant;
  dynamic get staff => _staff;
  int get admin => _admin;
  int get site => _site;
  String get name => _name;
  String get email => _email;
  String get mobile => _mobile;
  int get age => _age;
  dynamic get disease => _disease;
  String get bookingDate => _bookingDate;
  String get timeSerial => _timeSerial;
  int get pStatus => _pStatus;
  dynamic get trx => _trx;
  int get isComplete => _isComplete;
  int get dStatus => _dStatus;
  int get dDoctor => _dDoctor;
  dynamic get dAssistant => _dAssistant;
  dynamic get dStaff => _dStaff;
  int get dAdmin => _dAdmin;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Appointments({
    int id,
    int doctorId,
    dynamic customerId,
    dynamic entryDoctor,
    dynamic assistant,
    dynamic staff,
    int admin,
    int site,
    String name,
    String email,
    String mobile,
    int age,
    dynamic disease,
    String bookingDate,
    String timeSerial,
    int pStatus,
    dynamic trx,
    int isComplete,
    int dStatus,
    int dDoctor,
    dynamic dAssistant,
    dynamic dStaff,
    int dAdmin,
    String createdAt,
    String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _customerId = customerId;
    _entryDoctor = entryDoctor;
    _assistant = assistant;
    _staff = staff;
    _admin = admin;
    _site = site;
    _name = name;
    _email = email;
    _mobile = mobile;
    _age = age;
    _disease = disease;
    _bookingDate = bookingDate;
    _timeSerial = timeSerial;
    _pStatus = pStatus;
    _trx = trx;
    _isComplete = isComplete;
    _dStatus = dStatus;
    _dDoctor = dDoctor;
    _dAssistant = dAssistant;
    _dStaff = dStaff;
    _dAdmin = dAdmin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Appointments.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _customerId = json["customer_id"];
    _entryDoctor = json["entry_doctor"];
    _assistant = json["assistant"];
    _staff = json["staff"];
    _admin = json["admin"];
    _site = json["site"];
    _name = json["name"];
    _email = json["email"];
    _mobile = json["mobile"];
    _age = json["age"];
    _disease = json["disease"];
    _bookingDate = json["booking_date"];
    _timeSerial = json["time_serial"];
    _pStatus = json["p_status"];
    _trx = json["trx"];
    _isComplete = json["is_complete"];
    _dStatus = json["d_status"];
    _dDoctor = json["d_doctor"];
    _dAssistant = json["d_assistant"];
    _dStaff = json["d_staff"];
    _dAdmin = json["d_admin"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["customer_id"] = _customerId;
    map["entry_doctor"] = _entryDoctor;
    map["assistant"] = _assistant;
    map["staff"] = _staff;
    map["admin"] = _admin;
    map["site"] = _site;
    map["name"] = _name;
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["age"] = _age;
    map["disease"] = _disease;
    map["booking_date"] = _bookingDate;
    map["time_serial"] = _timeSerial;
    map["p_status"] = _pStatus;
    map["trx"] = _trx;
    map["is_complete"] = _isComplete;
    map["d_status"] = _dStatus;
    map["d_doctor"] = _dDoctor;
    map["d_assistant"] = _dAssistant;
    map["d_staff"] = _dStaff;
    map["d_admin"] = _dAdmin;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}


class Experience_details {
  int _id;
  int _doctorId;
  String _imagePath;
  String _institution;
  String _discipline;
  String _period;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  String get imagePath => _imagePath;
  String get institution => _institution;
  String get discipline => _discipline;
  String get period => _period;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Experience_details({
    int id,
    int doctorId,
    String imagePath,
    String institution,
    String discipline,
    String period,
    String createdAt,
    String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _imagePath = imagePath;
    _institution = institution;
    _discipline = discipline;
    _period = period;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Experience_details.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _imagePath = json["image_path"];
    _institution = json["institution"];
    _discipline = json["discipline"];
    _period = json["period"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["image_path"] = _imagePath;
    map["institution"] = _institution;
    map["discipline"] = _discipline;
    map["period"] = _period;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}


class Education_details {
  int _id;
  int _doctorId;
  String _imagePath;
  String _institution;
  String _discipline;
  String _period;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  String get imagePath => _imagePath;
  String get institution => _institution;
  String get discipline => _discipline;
  String get period => _period;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Education_details({
    int id,
    int doctorId,
    String imagePath,
    String institution,
    String discipline,
    String period,
    String createdAt,
    String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _imagePath = imagePath;
    _institution = institution;
    _discipline = discipline;
    _period = period;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Education_details.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _imagePath = json["image_path"];
    _institution = json["institution"];
    _discipline = json["discipline"];
    _period = json["period"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["image_path"] = _imagePath;
    map["institution"] = _institution;
    map["discipline"] = _discipline;
    map["period"] = _period;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}


class Clinics {
  int _id;
  int _doctorId;
  String _name;
  String _address;
  int _fees;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  String get name => _name;
  String get address => _address;
  int get fees =>_fees;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Clinics({
    int id,
    int doctorId,
    String name,
    String address,
    int fees,
    String createdAt,
    String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _name = name;
    _address = address;
    _fees = fees;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Clinics.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _name = json["name"];
    _address = json["address"];
    _fees = json["fees"].toString() == 'null'
        ?0
        :int.parse(json["fees"].toString());
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["name"] = _name;
    map["address"] = _address;
    map["fees"] = _fees;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}


class Schedules {
  int _id;
  int _doctorId;
  String _slotType;
  int _fees;
  String _startTime;
  String _endTime;
  String _serialDay;
  String _duration;
  List<String> _serialOrSlot;
  dynamic _clinicId;
  String _type;
  String _createdAt;
  String _updatedAt;
  ClinicModel _clinic;

  int get id => _id;
  int get doctorId => _doctorId;
  String get slotType => _slotType;
  int get fees => _fees;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get serialDay => _serialDay;
  String get duration => _duration;
  List<String> get serialOrSlot => _serialOrSlot;
  dynamic get clinicId => _clinicId;
  String get type => _type;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  ClinicModel get clinic => _clinic;

  Schedules({
    int id,
    int doctorId,
    String slotType,
    int fees,
    String startTime,
    String endTime,
    String serialDay,
    String duration,
    List<String> serialOrSlot,
    dynamic clinicId,
    String type,
    String createdAt,
    String updatedAt,
    ClinicModel clinic}){
    _id = id;
    _doctorId = doctorId;
    _slotType = slotType;
    _fees = fees;
    _startTime = startTime;
    _endTime = endTime;
    _serialDay = serialDay;
    _duration = duration;
    _serialOrSlot = serialOrSlot;
    _clinicId = clinicId;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _clinic = clinic;
  }

  Schedules.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _slotType = json["slot_type"];
    _fees = json["fees"];
    _startTime = json["start_time"];
    _endTime = json["end_time"];
    _serialDay = json["serial_day"];
    _duration = json["duration"];
    _serialOrSlot = json["serial_or_slot"] != null ? json["serial_or_slot"].cast<String>() : [];
    _clinicId = json["clinic_id"];
    _type = json["type"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    // _clinic = json["clinic"];
    _clinic = json["clinic"] != null ? ClinicModel.fromJson(json["clinic"]) : null;

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["slot_type"] = _slotType;
    map["fees"] = _fees;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["serial_day"] = _serialDay;
    map["duration"] = _duration;
    map["serial_or_slot"] = _serialOrSlot;
    map["clinic_id"] = _clinicId;
    map["type"] = _type;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    // map["clinic"] = _clinic;
    if (_clinic != null) {
      map["clinic"] = _clinic.toJson();
    }
    return map;
  }

}


class ClinicModel {
  int _id;
  int _doctorId;
  String _name;
  String _address;
  int _fees;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  String get name => _name;
  String get address => _address;
  int get fees => _fees;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  ClinicModel({
    int id,
    int doctorId,
    String name,
    String address,
    int fees,
    String createdAt,
    String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _name = name;
    _address = address;
    _fees = fees;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ClinicModel.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _name = json["name"];
    _address = json["address"];
    _fees = json["fees"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["name"] = _name;
    map["address"] = _address;
    map["fees"] = _fees;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}