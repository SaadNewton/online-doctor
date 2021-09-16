/// status : true
/// success : 1
/// message : "Appointment has been Successfully approved"

class ApproveAppointmentModel {
  bool? _status;
  int? _success;
  String? _message;

  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  ApproveAppointmentModel({
      bool? status, 
      int? success, 
      String? message}){
    _status = status;
    _success = success;
    _message = message;
}

  ApproveAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}