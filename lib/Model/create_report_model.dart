/// data : {"id":6,"doctor_id":1,"customer_id":2,"clinic_id":null,"entry_doctor":null,"assistant":null,"staff":null,"admin":0,"site":1,"name":"Bilal Hassan","email":"hassanbilal099@gmail.com","mobile":"03477459552","age":27,"disease":"rwerewr","booking_date":"2021-10-12","booking_type":"online","time_serial":"02:45:am","p_status":1,"trx":null,"try":1,"is_complete":1,"is_prescription":"1","d_status":0,"d_doctor":null,"d_assistant":null,"d_staff":null,"d_admin":0,"health":"[\"25\",\"45\"]","prescription_url":"storage/pdf/pdf_617949c9887f3.pdf","total_day":null,"created_at":"2021-10-12 06:46:37","updated_at":"2021-10-12 06:48:59"}
/// status : true
/// success : 1
/// message : "Pdf generate successfully"

class CreateReportModel {
  CreateReportModel({
    Data? data,
    bool? status,
    int? success,
    String? message,
  }) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  CreateReportModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }
  Data? _data;
  bool? _status;
  int? _success;
  String? _message;

  Data? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }
}

/// id : 6
/// doctor_id : 1
/// customer_id : 2
/// clinic_id : null
/// entry_doctor : null
/// assistant : null
/// staff : null
/// admin : 0
/// site : 1
/// name : "Bilal Hassan"
/// email : "hassanbilal099@gmail.com"
/// mobile : "03477459552"
/// age : 27
/// disease : "rwerewr"
/// booking_date : "2021-10-12"
/// booking_type : "online"
/// time_serial : "02:45:am"
/// p_status : 1
/// trx : null
/// try : 1
/// is_complete : 1
/// is_prescription : "1"
/// d_status : 0
/// d_doctor : null
/// d_assistant : null
/// d_staff : null
/// d_admin : 0
/// health : "[\"25\",\"45\"]"
/// prescription_url : "storage/pdf/pdf_617949c9887f3.pdf"
/// total_day : null
/// created_at : "2021-10-12 06:46:37"
/// updated_at : "2021-10-12 06:48:59"

class Data {
  Data({
    int? id,
    int? doctorId,
    int? customerId,
    dynamic clinicId,
    dynamic entryDoctor,
    dynamic assistant,
    dynamic staff,
    int? admin,
    int? site,
    String? name,
    String? email,
    String? mobile,
    int? age,
    String? disease,
    String? bookingDate,
    String? bookingType,
    String? timeSerial,
    int? pStatus,
    dynamic trx,
    int? isComplete,
    String? isPrescription,
    int? dStatus,
    dynamic dDoctor,
    dynamic dAssistant,
    dynamic dStaff,
    int? dAdmin,
    String? health,
    String? prescriptionUrl,
    dynamic totalDay,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _doctorId = doctorId;
    _customerId = customerId;
    _clinicId = clinicId;
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
    _bookingType = bookingType;
    _timeSerial = timeSerial;
    _pStatus = pStatus;
    _trx = trx;

    _isComplete = isComplete;
    _isPrescription = isPrescription;
    _dStatus = dStatus;
    _dDoctor = dDoctor;
    _dAssistant = dAssistant;
    _dStaff = dStaff;
    _dAdmin = dAdmin;
    _health = health;
    _prescriptionUrl = prescriptionUrl;
    _totalDay = totalDay;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _customerId = json['customer_id'];
    _clinicId = json['clinic_id'];
    _entryDoctor = json['entry_doctor'];
    _assistant = json['assistant'];
    _staff = json['staff'];
    _admin = json['admin'];
    _site = json['site'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _age = json['age'];
    _disease = json['disease'];
    _bookingDate = json['booking_date'];
    _bookingType = json['booking_type'];
    _timeSerial = json['time_serial'];
    _pStatus = json['p_status'];
    _trx = json['trx'];
    _try = json['try'];
    _isComplete = json['is_complete'];
    _isPrescription = json['is_prescription'];
    _dStatus = json['d_status'];
    _dDoctor = json['d_doctor'];
    _dAssistant = json['d_assistant'];
    _dStaff = json['d_staff'];
    _dAdmin = json['d_admin'];
    _health = json['health'];
    _prescriptionUrl = json['prescription_url'];
    _totalDay = json['total_day'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _doctorId;
  int? _customerId;
  dynamic _clinicId;
  dynamic _entryDoctor;
  dynamic _assistant;
  dynamic _staff;
  int? _admin;
  int? _site;
  String? _name;
  String? _email;
  String? _mobile;
  int? _age;
  String? _disease;
  String? _bookingDate;
  String? _bookingType;
  String? _timeSerial;
  int? _pStatus;
  dynamic _trx;
  int? _try;
  int? _isComplete;
  String? _isPrescription;
  int? _dStatus;
  dynamic _dDoctor;
  dynamic _dAssistant;
  dynamic _dStaff;
  int? _dAdmin;
  String? _health;
  String? _prescriptionUrl;
  dynamic _totalDay;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get doctorId => _doctorId;
  int? get customerId => _customerId;
  dynamic get clinicId => _clinicId;
  dynamic get entryDoctor => _entryDoctor;
  dynamic get assistant => _assistant;
  dynamic get staff => _staff;
  int? get admin => _admin;
  int? get site => _site;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get age => _age;
  String? get disease => _disease;
  String? get bookingDate => _bookingDate;
  String? get bookingType => _bookingType;
  String? get timeSerial => _timeSerial;
  int? get pStatus => _pStatus;
  dynamic get trx => _trx;
  int? get isComplete => _isComplete;
  String? get isPrescription => _isPrescription;
  int? get dStatus => _dStatus;
  dynamic get dDoctor => _dDoctor;
  dynamic get dAssistant => _dAssistant;
  dynamic get dStaff => _dStaff;
  int? get dAdmin => _dAdmin;
  String? get health => _health;
  String? get prescriptionUrl => _prescriptionUrl;
  dynamic get totalDay => _totalDay;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['customer_id'] = _customerId;
    map['clinic_id'] = _clinicId;
    map['entry_doctor'] = _entryDoctor;
    map['assistant'] = _assistant;
    map['staff'] = _staff;
    map['admin'] = _admin;
    map['site'] = _site;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['age'] = _age;
    map['disease'] = _disease;
    map['booking_date'] = _bookingDate;
    map['booking_type'] = _bookingType;
    map['time_serial'] = _timeSerial;
    map['p_status'] = _pStatus;
    map['trx'] = _trx;
    map['try'] = _try;
    map['is_complete'] = _isComplete;
    map['is_prescription'] = _isPrescription;
    map['d_status'] = _dStatus;
    map['d_doctor'] = _dDoctor;
    map['d_assistant'] = _dAssistant;
    map['d_staff'] = _dStaff;
    map['d_admin'] = _dAdmin;
    map['health'] = _health;
    map['prescription_url'] = _prescriptionUrl;
    map['total_day'] = _totalDay;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
