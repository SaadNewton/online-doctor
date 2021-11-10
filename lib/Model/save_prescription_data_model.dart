/// data : {"id":2,"appointment_id":6,"item_id":23,"item_name":"test","tad":"Three a day","frequency":"One","created_at":"2021-10-27T11:29:45.000000Z","updated_at":"2021-10-27T11:29:45.000000Z","item":{"id":23,"product_category_id":1,"company_id":2,"name":"GABA-50MG","salt_name":"","slug":"GABA-50MG","potency":"","image_path":null,"retail_price":"0","sale_price":"0","on_sale":"yes","is_feature":"0","is_item_type":"0","item_type_price":null,"sku":"2104","status":"","is_active":"","description":"Get Your Medicine ","created_at":"2021-08-26T10:55:02.000000Z","updated_at":"2021-08-26T10:55:38.000000Z"}}
/// status : true
/// success : 1
/// message : "Data save successfully"

class SavePrescriptionDataModel {
  SavePrescriptionDataModel({
      Data? data, 
      bool? status, 
      int? success, 
      String? message,}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  SavePrescriptionDataModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }
  Data? _data;
  bool? _status;
  int? _success;
  String? _message;

  Data? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : 2
/// appointment_id : 6
/// item_id : 23
/// item_name : "test"
/// tad : "Three a day"
/// frequency : "One"
/// created_at : "2021-10-27T11:29:45.000000Z"
/// updated_at : "2021-10-27T11:29:45.000000Z"
/// item : {"id":23,"product_category_id":1,"company_id":2,"name":"GABA-50MG","salt_name":"","slug":"GABA-50MG","potency":"","image_path":null,"retail_price":"0","sale_price":"0","on_sale":"yes","is_feature":"0","is_item_type":"0","item_type_price":null,"sku":"2104","status":"","is_active":"","description":"Get Your Medicine ","created_at":"2021-08-26T10:55:02.000000Z","updated_at":"2021-08-26T10:55:38.000000Z"}

class Data {
  Data({
      int? id, 
      int? appointmentId, 
      int? itemId, 
      String? itemName, 
      String? tad, 
      String? frequency, 
      String? createdAt, 
      String? updatedAt, 
      Item? item,}){
    _id = id;
    _appointmentId = appointmentId;
    _itemId = itemId;
    _itemName = itemName;
    _tad = tad;
    _frequency = frequency;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _item = item;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _appointmentId = json['appointment_id'];
    _itemId = json['item_id'];
    _itemName = json['item_name'];
    _tad = json['tad'];
    _frequency = json['frequency'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
  int? _id;
  int? _appointmentId;
  int? _itemId;
  String? _itemName;
  String? _tad;
  String? _frequency;
  String? _createdAt;
  String? _updatedAt;
  Item? _item;

  int? get id => _id;
  int? get appointmentId => _appointmentId;
  int? get itemId => _itemId;
  String? get itemName => _itemName;
  String? get tad => _tad;
  String? get frequency => _frequency;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Item? get item => _item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['appointment_id'] = _appointmentId;
    map['item_id'] = _itemId;
    map['item_name'] = _itemName;
    map['tad'] = _tad;
    map['frequency'] = _frequency;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    return map;
  }

}

/// id : 23
/// product_category_id : 1
/// company_id : 2
/// name : "GABA-50MG"
/// salt_name : ""
/// slug : "GABA-50MG"
/// potency : ""
/// image_path : null
/// retail_price : "0"
/// sale_price : "0"
/// on_sale : "yes"
/// is_feature : "0"
/// is_item_type : "0"
/// item_type_price : null
/// sku : "2104"
/// status : ""
/// is_active : ""
/// description : "Get Your Medicine "
/// created_at : "2021-08-26T10:55:02.000000Z"
/// updated_at : "2021-08-26T10:55:38.000000Z"

class Item {
  Item({
      int? id, 
      int? productCategoryId, 
      int? companyId, 
      String? name, 
      String? saltName, 
      String? slug, 
      String? potency, 
      dynamic imagePath, 
      String? retailPrice, 
      String? salePrice, 
      String? onSale, 
      String? isFeature, 
      String? isItemType, 
      dynamic itemTypePrice, 
      String? sku, 
      String? status, 
      String? isActive, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _productCategoryId = productCategoryId;
    _companyId = companyId;
    _name = name;
    _saltName = saltName;
    _slug = slug;
    _potency = potency;
    _imagePath = imagePath;
    _retailPrice = retailPrice;
    _salePrice = salePrice;
    _onSale = onSale;
    _isFeature = isFeature;
    _isItemType = isItemType;
    _itemTypePrice = itemTypePrice;
    _sku = sku;
    _status = status;
    _isActive = isActive;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Item.fromJson(dynamic json) {
    _id = json['id'];
    _productCategoryId = json['product_category_id'];
    _companyId = json['company_id'];
    _name = json['name'];
    _saltName = json['salt_name'];
    _slug = json['slug'];
    _potency = json['potency'];
    _imagePath = json['image_path'];
    _retailPrice = json['retail_price'];
    _salePrice = json['sale_price'];
    _onSale = json['on_sale'];
    _isFeature = json['is_feature'];
    _isItemType = json['is_item_type'];
    _itemTypePrice = json['item_type_price'];
    _sku = json['sku'];
    _status = json['status'];
    _isActive = json['is_active'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _productCategoryId;
  int? _companyId;
  String? _name;
  String? _saltName;
  String? _slug;
  String? _potency;
  dynamic _imagePath;
  String? _retailPrice;
  String? _salePrice;
  String? _onSale;
  String? _isFeature;
  String? _isItemType;
  dynamic _itemTypePrice;
  String? _sku;
  String? _status;
  String? _isActive;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get productCategoryId => _productCategoryId;
  int? get companyId => _companyId;
  String? get name => _name;
  String? get saltName => _saltName;
  String? get slug => _slug;
  String? get potency => _potency;
  dynamic get imagePath => _imagePath;
  String? get retailPrice => _retailPrice;
  String? get salePrice => _salePrice;
  String? get onSale => _onSale;
  String? get isFeature => _isFeature;
  String? get isItemType => _isItemType;
  dynamic get itemTypePrice => _itemTypePrice;
  String? get sku => _sku;
  String? get status => _status;
  String? get isActive => _isActive;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_category_id'] = _productCategoryId;
    map['company_id'] = _companyId;
    map['name'] = _name;
    map['salt_name'] = _saltName;
    map['slug'] = _slug;
    map['potency'] = _potency;
    map['image_path'] = _imagePath;
    map['retail_price'] = _retailPrice;
    map['sale_price'] = _salePrice;
    map['on_sale'] = _onSale;
    map['is_feature'] = _isFeature;
    map['is_item_type'] = _isItemType;
    map['item_type_price'] = _itemTypePrice;
    map['sku'] = _sku;
    map['status'] = _status;
    map['is_active'] = _isActive;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}