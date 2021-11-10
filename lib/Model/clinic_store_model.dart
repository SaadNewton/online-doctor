//@dart=2.9

class ClinicStoreModel {
  ClinicStoreModelData _data;
  bool _status;
  int _success;
  String _message;

  ClinicStoreModelData get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  ClinicStoreModel({
    ClinicStoreModelData data,
      bool status, 
      int success, 
      String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  ClinicStoreModel.fromJson(dynamic json) {
    _data = json["data"] != null ? ClinicStoreModelData.fromJson(json["data"]) : null;
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


class ClinicStoreModelData {
  String _doctorId;
  String _name;
  String _address;
  int _fees;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get doctorId => _doctorId;
  String get name => _name;
  String get address => _address;
  int get fees => _fees;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  ClinicStoreModelData({
      String doctorId, 
      String name, 
      String address,
    int fees,
      String updatedAt, 
      String createdAt, 
      int id}){
    _doctorId = doctorId;
    _name = name;
    _address = address;
    _fees = fees;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  ClinicStoreModelData.fromJson(dynamic json) {
    _doctorId = json["doctor_id"].toString();
    _name = json["name"];
    _address = json["address"];
    _fees = int.parse(json["fees"].toString());
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["doctor_id"] = _doctorId;
    map["name"] = _name;
    map["address"] = _address;
    map["fees"] = _fees;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }

}