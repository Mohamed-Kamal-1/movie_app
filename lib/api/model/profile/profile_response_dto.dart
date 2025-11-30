/// message : "Profile fetched successfully"
/// data : {"_id":"6929c0dd63a8bee530e5d425","email":"tijocij403@httpsu.com","password":"$2b$10$sBUGFeZSbjiBEmSPHR3GjeHBT.RHR8c03qv9yh3b5HteFacWQ2//.","name":"amr mustafa","phone":"+201141209334","avaterId":1,"createdAt":"2025-11-28T15:33:49.830Z","updatedAt":"2025-11-28T15:33:49.830Z","__v":0}
library;

class ProfileResponseDto {
  ProfileResponseDto({
      this.message, 
      this.data,});

  ProfileResponseDto.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// _id : "6929c0dd63a8bee530e5d425"
/// email : "tijocij403@httpsu.com"
/// password : "$2b$10$sBUGFeZSbjiBEmSPHR3GjeHBT.RHR8c03qv9yh3b5HteFacWQ2//."
/// name : "amr mustafa"
/// phone : "+201141209334"
/// avaterId : 1
/// createdAt : "2025-11-28T15:33:49.830Z"
/// updatedAt : "2025-11-28T15:33:49.830Z"
/// __v : 0

class Data {
  Data({
      this.id, 
      this.email, 
      this.password, 
      this.name, 
      this.phone, 
      this.avaterId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}