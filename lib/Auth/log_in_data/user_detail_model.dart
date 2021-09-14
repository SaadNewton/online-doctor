/// data : {"id":1,"name":"Bilal Hassan","username":"bilalhassan099","email":"hassanbilal099@gmail.com","mobile":"03477459552","ref_by":null,"balance":"0.00000000","image":"60db07d02f0761624967120.jpg","address":"kohenoor 1 plaza","lat":null,"long":null,"sector_id":1,"location_id":1,"qualification":"Optometry","rating":4,"status":1,"ev":1,"sv":1,"ver_code":null,"ver_code_send_at":null,"ts":0,"tv":1,"tsc":null,"fees":500,"slot_type":2,"start_time":"09:00 am","end_time":"05:00 pm","serial_day":5,"max_serial":0,"duration":60,"serial_or_slot":["09:00:am","10:00:am","11:00:am","12:00:pm","01:00:pm","02:00:pm","03:00:pm","04:00:pm"],"about":"tesitin doctor","featured":1,"speciality":null,"created_at":"2021-06-25T03:47:41.000000Z","updated_at":"2021-06-29T08:45:20.000000Z","auth":{"id":4,"user_id":1,"role":"doctor","token":"1ca40c63eff40b1cda4245600f5a413226c463cc584f3065ee28bb77881b2b8509edcffb150c61738350655fa7dc96e9c3ca","created_at":null,"updated_at":null}}
/// status : true
/// success : 1
/// message : "Authenticate user successfully"
// @dart=2.10
class UserDetailModel {
  UserDetailData _data;
  bool _status;
  int _success;
  String _message;

  UserDetailData get data => _data;

  bool get status => _status;

  int get success => _success;

  String get message => _message;

  UserDetailModel({
    UserDetailData data,
    bool status,
    int success,
    String message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  UserDetailModel.fromJson(dynamic json) {
    _data = json['data'] != null ? UserDetailData.fromJson(json['data']) : null;
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : 1
/// name : "Bilal Hassan"
/// username : "bilalhassan099"
/// email : "hassanbilal099@gmail.com"
/// mobile : "03477459552"
/// ref_by : null
/// balance : "0.00000000"
/// image : "60db07d02f0761624967120.jpg"
/// address : "kohenoor 1 plaza"
/// lat : null
/// long : null
/// sector_id : 1
/// location_id : 1
/// qualification : "Optometry"
/// rating : 4
/// status : 1
/// ev : 1
/// sv : 1
/// ver_code : null
/// ver_code_send_at : null
/// ts : 0
/// tv : 1
/// tsc : null
/// fees : 500
/// slot_type : 2
/// start_time : "09:00 am"
/// end_time : "05:00 pm"
/// serial_day : 5
/// max_serial : 0
/// duration : 60
/// serial_or_slot : ["09:00:am","10:00:am","11:00:am","12:00:pm","01:00:pm","02:00:pm","03:00:pm","04:00:pm"]
/// about : "tesitin doctor"
/// featured : 1
/// speciality : null
/// created_at : "2021-06-25T03:47:41.000000Z"
/// updated_at : "2021-06-29T08:45:20.000000Z"
/// auth : {"id":4,"user_id":1,"role":"doctor","token":"1ca40c63eff40b1cda4245600f5a413226c463cc584f3065ee28bb77881b2b8509edcffb150c61738350655fa7dc96e9c3ca","created_at":null,"updated_at":null}

class UserDetailData {
  int _id;
  String _name;
  String _username;
  String _email;
  String _mobile;
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
  dynamic _speciality;
  String _createdAt;
  String _updatedAt;
  Auth _auth;

  int get id => _id;

  String get name => _name;

  String get username => _username;

  String get email => _email;

  String get mobile => _mobile;

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

  dynamic get speciality => _speciality;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  Auth get auth => _auth;

  Data({
    int id,
    String name,
    String username,
    String email,
    String mobile,
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
    dynamic speciality,
    String createdAt,
    String updatedAt,
    Auth auth}) {
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _mobile = mobile;
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
    _auth = auth;
  }

  UserDetailData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _refBy = json['ref_by'];
    _balance = json['balance'];
    _image = json['image'];
    _address = json['address'];
    _lat = json['lat'];
    _long = json['long'];
    _sectorId = json['sector_id'];
    _locationId = json['location_id'];
    _qualification = json['qualification'];
    _rating = json['rating'];
    _status = json['status'];
    _ev = json['ev'];
    _sv = json['sv'];
    _verCode = json['ver_code'];
    _verCodeSendAt = json['ver_code_send_at'];
    _ts = json['ts'];
    _tv = json['tv'];
    _tsc = json['tsc'];
    _fees = json['fees'];
    _slotType = json['slot_type'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _serialDay = json['serial_day'];
    _maxSerial = json['max_serial'];
    _duration = json['duration'];
    _serialOrSlot =
    json['serial_or_slot'] != null ? json['serial_or_slot'].cast<String>() : [];
    _about = json['about'];
    _featured = json['featured'];
    _speciality = json['speciality'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    map['address'] = _address;
    map['lat'] = _lat;
    map['long'] = _long;
    map['sector_id'] = _sectorId;
    map['location_id'] = _locationId;
    map['qualification'] = _qualification;
    map['rating'] = _rating;
    map['status'] = _status;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['fees'] = _fees;
    map['slot_type'] = _slotType;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['serial_day'] = _serialDay;
    map['max_serial'] = _maxSerial;
    map['duration'] = _duration;
    map['serial_or_slot'] = _serialOrSlot;
    map['about'] = _about;
    map['featured'] = _featured;
    map['speciality'] = _speciality;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_auth != null) {
      map['auth'] = _auth.toJson();
    }
    return map;
  }

}

/// id : 4
/// user_id : 1
/// role : "doctor"
/// token : "1ca40c63eff40b1cda4245600f5a413226c463cc584f3065ee28bb77881b2b8509edcffb150c61738350655fa7dc96e9c3ca"
/// created_at : null
/// updated_at : null

class Auth {
  int _id;
  int _userId;
  String _role;
  String _token;
  dynamic _createdAt;
  dynamic _updatedAt;

  int get id => _id;

  int get userId => _userId;

  String get role => _role;

  String get token => _token;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  Auth({
    int id,
    int userId,
    String role,
    String token,
    dynamic createdAt,
    dynamic updatedAt}) {
    _id = id;
    _userId = userId;
    _role = role;
    _token = token;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Auth.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _role = json['role'];
    _token = json['token'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['role'] = _role;
    map['token'] = _token;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}