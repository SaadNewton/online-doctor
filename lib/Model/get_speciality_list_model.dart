//@dart=2.9
class GetSpecialityListModel {
  List<GetSpecialityListModelData> _data;
  bool _status;
  int _success;
  String _message;

  List<GetSpecialityListModelData> get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetSpecialityListModel(
      {List<GetSpecialityListModelData> data,
      bool status,
      int success,
      String message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetSpecialityListModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(GetSpecialityListModelData.fromJson(v));
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

/// id : 1
/// name : "Eyes Specialist"
/// is_active : 1
/// created_at : null
/// updated_at : null

class GetSpecialityListModelData {
  int _id;
  String _name;
  int _isActive;
  dynamic _createdAt;
  dynamic _updatedAt;

  int get id => _id;
  String get name => _name;
  int get isActive => _isActive;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  GetSpecialityListModelData(
      {int id,
      String name,
      int isActive,
      dynamic createdAt,
      dynamic updatedAt}) {
    _id = id;
    _name = name;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetSpecialityListModelData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _isActive = json["is_active"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["is_active"] = _isActive;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
