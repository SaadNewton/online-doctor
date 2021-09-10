/// phone : false
/// email : false

class CheckStatusModel {
  bool? _phone;
  bool? _email;

  bool? get phone => _phone;
  bool? get email => _email;

  CheckStatusModel({
      bool? phone, 
      bool? email}){
    _phone = phone;
    _email = email;
}

  CheckStatusModel.fromJson(dynamic json) {
    _phone = json['phone'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['phone'] = _phone;
    map['email'] = _email;
    return map;
  }

}