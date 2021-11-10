/// status : false
/// success : 0
/// message : "Missing fields are required"
/// validation : {"doctor_id":["The doctor id field is required."],"institution":["The institution field is required."],"discipline":["The discipline field is required."],"period":["The period field is required."],"image":["The image field is required."]}

class EducationModel {
  bool? _status;
  int? _success;
  String? _message;
  Validation? _validation;

  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;
  Validation? get validation => _validation;

  EducationModel({
      bool? status, 
      int? success, 
      String? message, 
      Validation? validation}){
    _status = status;
    _success = success;
    _message = message;
    _validation = validation;
}

  EducationModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
    _validation = json['validation'] != null ? Validation.fromJson(json['validation']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    if (_validation != null) {
      map['validation'] = _validation?.toJson();
    }
    return map;
  }

}

/// doctor_id : ["The doctor id field is required."]
/// institution : ["The institution field is required."]
/// discipline : ["The discipline field is required."]
/// period : ["The period field is required."]
/// image : ["The image field is required."]

class Validation {
  List<String>? _doctorId;
  List<String>? _institution;
  List<String>? _discipline;
  List<String>? _period;
  List<String>? _image;

  List<String>? get doctorId => _doctorId;
  List<String>? get institution => _institution;
  List<String>? get discipline => _discipline;
  List<String>? get period => _period;
  List<String>? get image => _image;

  Validation({
      List<String>? doctorId, 
      List<String>? institution, 
      List<String>? discipline, 
      List<String>? period, 
      List<String>? image}){
    _doctorId = doctorId;
    _institution = institution;
    _discipline = discipline;
    _period = period;
    _image = image;
}

  Validation.fromJson(dynamic json) {
    _doctorId = json['doctor_id'] != null ? json['doctor_id'].cast<String>() : [];
    _institution = json['institution'] != null ? json['institution'].cast<String>() : [];
    _discipline = json['discipline'] != null ? json['discipline'].cast<String>() : [];
    _period = json['period'] != null ? json['period'].cast<String>() : [];
    _image = json['image'] != null ? json['image'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['doctor_id'] = _doctorId;
    map['institution'] = _institution;
    map['discipline'] = _discipline;
    map['period'] = _period;
    map['image'] = _image;
    return map;
  }

}