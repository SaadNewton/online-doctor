/// data : [{"id":1,"sender_id":1,"sender_name":"Bilal","reciever_id":2,"reciever_name":"Bilal Hassan","message":"hi","created_at":"2021-10-12T05:50:22.000000Z","updated_at":"2021-10-12T05:50:22.000000Z"},{"id":2,"sender_id":2,"sender_name":"Bilal Hassan","reciever_id":1,"reciever_name":"Bilal","message":"hi","created_at":"2021-10-12T05:52:15.000000Z","updated_at":"2021-10-12T05:52:15.000000Z"}]
/// status : true
/// success : 1
/// message : "Fetching record"

class FetchChatModel {
  List<ChatData>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<ChatData>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  FetchChatModel({
      List<ChatData>? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  FetchChatModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(ChatData.fromJson(v));
      });
    }
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}

/// id : 1
/// sender_id : 1
/// sender_name : "Bilal"
/// reciever_id : 2
/// reciever_name : "Bilal Hassan"
/// message : "hi"
/// created_at : "2021-10-12T05:50:22.000000Z"
/// updated_at : "2021-10-12T05:50:22.000000Z"

class ChatData {
  int? _id;
  int? _senderId;
  String? _senderName;
  int? _recieverId;
  String? _recieverName;
  String? _message;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get senderId => _senderId;
  String? get senderName => _senderName;
  int? get recieverId => _recieverId;
  String? get recieverName => _recieverName;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ChatData({
      int? id, 
      int? senderId, 
      String? senderName, 
      int? recieverId, 
      String? recieverName, 
      String? message, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _senderId = senderId;
    _senderName = senderName;
    _recieverId = recieverId;
    _recieverName = recieverName;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ChatData.fromJson(dynamic json) {
    _id = json["id"];
    _senderId = json["sender_id"];
    _senderName = json["sender_name"];
    _recieverId = json["reciever_id"];
    _recieverName = json["reciever_name"];
    _message = json["message"].toString();
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sender_id"] = _senderId;
    map["sender_name"] = _senderName;
    map["reciever_id"] = _recieverId;
    map["reciever_name"] = _recieverName;
    map["message"] = _message;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}