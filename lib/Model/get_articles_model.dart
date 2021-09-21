//@dart=2.9

class GetArticlesModel {
  List<GetArticlesModelData> _data;
  bool _status;
  int _success;
  String _message;

  List<GetArticlesModelData> get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetArticlesModel({
      List<GetArticlesModelData> data,
      bool status, 
      int success, 
      String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetArticlesModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(GetArticlesModelData.fromJson(v));
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

/// id : 3
/// doctor_id : 49
/// title : "test"
/// image : null
/// description : "testetget"
/// created_at : "2021-09-21T10:48:40.000000Z"
/// updated_at : "2021-09-21T10:48:40.000000Z"

class GetArticlesModelData {
  int _id;
  int _doctorId;
  String _title;
  dynamic _image;
  String _description;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get doctorId => _doctorId;
  String get title => _title;
  dynamic get image => _image;
  String get description => _description;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  GetArticlesModelData({
      int id, 
      int doctorId, 
      String title, 
      dynamic image, 
      String description, 
      String createdAt, 
      String updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _title = title;
    _image = image;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  GetArticlesModelData.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _title = json["title"];
    _image = json["image"];
    _description = json["description"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
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
    return map;
  }

}