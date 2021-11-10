/// data : [{"is_prescription":"1","prescription_url":"storage/pdf/pdf_617a3e5c80abe.pdf"}]
/// status : true
/// success : 1
/// message : "Fetching data"

class PrescriptionUrlModel {
  List<Data>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Data>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  PrescriptionUrlModel(
      {List<Data>? data, bool? status, int? success, String? message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  PrescriptionUrlModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
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

/// is_prescription : "1"
/// prescription_url : "storage/pdf/pdf_617a3e5c80abe.pdf"

class Data {
  String? _isPrescription;
  String? _prescriptionUrl;

  String? get isPrescription => _isPrescription;
  String? get prescriptionUrl => _prescriptionUrl;

  Data({String? isPrescription, String? prescriptionUrl}) {
    _isPrescription = isPrescription;
    _prescriptionUrl = prescriptionUrl;
  }

  Data.fromJson(dynamic json) {
    _isPrescription = json['is_prescription'];
    _prescriptionUrl = json['prescription_url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['is_prescription'] = _isPrescription;
    map['prescription_url'] = _prescriptionUrl;
    return map;
  }
}
