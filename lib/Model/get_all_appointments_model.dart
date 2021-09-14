/// data : [{"id":1,"doctor_id":1,"entry_doctor":null,"assistant":null,"staff":null,"admin":0,"site":1,"name":"Bilal Hassan","email":"hassanbilal099@gmail.com","mobile":"03477459552","age":22,"disease":"tte6tretrtter","booking_date":"2021-06-29","time_serial":"09:00:am","p_status":0,"trx":null,"try":1,"is_complete":0,"d_status":0,"d_doctor":null,"d_assistant":null,"d_staff":null,"d_admin":0,"created_at":"2021-06-29T02:43:30.000000Z","updated_at":"2021-06-29T02:43:30.000000Z"},{"id":4,"doctor_id":1,"entry_doctor":null,"assistant":null,"staff":null,"admin":0,"site":0,"name":"Bilal Hassan","email":"hassanbilal099@gmail.com","mobile":"03477459552","age":25,"disease":"asasasazs","booking_date":"2021-06-29","time_serial":"10:00:am","p_status":0,"trx":"O6YFC4TQNEM1","try":0,"is_complete":0,"d_status":0,"d_doctor":null,"d_assistant":null,"d_staff":null,"d_admin":0,"created_at":"2021-06-29T03:59:06.000000Z","updated_at":"2021-06-29T03:59:06.000000Z"}]
/// status : true
/// success : 1
/// message : "Fetching record"

class GetAllAppointmentsModel {
  List<Appointments>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Appointments>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllAppointmentsModel({
      List<Appointments>? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAllAppointmentsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Appointments.fromJson(v));
      });
    }
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : 1
/// doctor_id : 1
/// entry_doctor : null
/// assistant : null
/// staff : null
/// admin : 0
/// site : 1
/// name : "Bilal Hassan"
/// email : "hassanbilal099@gmail.com"
/// mobile : "03477459552"
/// age : 22
/// disease : "tte6tretrtter"
/// booking_date : "2021-06-29"
/// time_serial : "09:00:am"
/// p_status : 0
/// trx : null
/// try : 1
/// is_complete : 0
/// d_status : 0
/// d_doctor : null
/// d_assistant : null
/// d_staff : null
/// d_admin : 0
/// created_at : "2021-06-29T02:43:30.000000Z"
/// updated_at : "2021-06-29T02:43:30.000000Z"

class Appointments {
  int? _id;
  int? _doctorId;
  dynamic? _entryDoctor;
  dynamic? _assistant;
  dynamic? _staff;
  int? _admin;
  int? _site;
  String? _name;
  String? _email;
  String? _mobile;
  int? _age;
  String? _disease;
  String? _bookingDate;
  String? _timeSerial;
  int? _pStatus;
  dynamic? _trx;
  int? _try;
  int? _isComplete;
  int? _dStatus;
  dynamic? _dDoctor;
  dynamic? _dAssistant;
  dynamic? _dStaff;
  int? _dAdmin;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get doctorId => _doctorId;
  dynamic? get entryDoctor => _entryDoctor;
  dynamic? get assistant => _assistant;
  dynamic? get staff => _staff;
  int? get admin => _admin;
  int? get site => _site;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get age => _age;
  String? get disease => _disease;
  String? get bookingDate => _bookingDate;
  String? get timeSerial => _timeSerial;
  int? get pStatus => _pStatus;
  dynamic? get trx => _trx;
  int? get isComplete => _isComplete;
  int? get dStatus => _dStatus;
  dynamic? get dDoctor => _dDoctor;
  dynamic? get dAssistant => _dAssistant;
  dynamic? get dStaff => _dStaff;
  int? get dAdmin => _dAdmin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Data({
      int? id, 
      int? doctorId, 
      dynamic? entryDoctor, 
      dynamic? assistant, 
      dynamic? staff, 
      int? admin, 
      int? site, 
      String? name, 
      String? email, 
      String? mobile, 
      int? age, 
      String? disease, 
      String? bookingDate, 
      String? timeSerial, 
      int? pStatus, 
      dynamic? trx,
      int? isComplete, 
      int? dStatus, 
      dynamic? dDoctor, 
      dynamic? dAssistant, 
      dynamic? dStaff, 
      int? dAdmin, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _doctorId = doctorId;
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
    _id = json['id'];
    _doctorId = json['doctor_id'];
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
    _timeSerial = json['time_serial'];
    _pStatus = json['p_status'];
    _trx = json['trx'];
    _try = json['try'];
    _isComplete = json['is_complete'];
    _dStatus = json['d_status'];
    _dDoctor = json['d_doctor'];
    _dAssistant = json['d_assistant'];
    _dStaff = json['d_staff'];
    _dAdmin = json['d_admin'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
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
    map['time_serial'] = _timeSerial;
    map['p_status'] = _pStatus;
    map['trx'] = _trx;
    map['try'] = _try;
    map['is_complete'] = _isComplete;
    map['d_status'] = _dStatus;
    map['d_doctor'] = _dDoctor;
    map['d_assistant'] = _dAssistant;
    map['d_staff'] = _dStaff;
    map['d_admin'] = _dAdmin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}