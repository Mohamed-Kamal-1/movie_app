import 'package:movie_app/auth/domain/entities/auth_result.dart';
import 'data_model.dart';

/// message : "User created successfully"
/// data : {"email":"test@test.com","password":"$2b$10$BDSuPL8YNXNDt5B.jodun.dy7nDohpepMOUccOge1B4YB8/nGVyOC","name":"test","phone":"+201111111111","avaterId":1,"_id":"6920c2c0162367cc49c6b670","createdAt":"2025-11-21T19:51:28.406Z","updatedAt":"2025-11-21T19:51:28.406Z","__v":0}

class RegisterModel {
  RegisterModel({
    this.message,
    this.data,
  });

  RegisterModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  String? message;
  DataModel? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }

    return map;
  }

  AuthResult toEntity() {
    return AuthResult(message: message ?? '', data: data);
  }
}


/// email : "test@test.com"
/// password : "$2b$10$BDSuPL8YNXNDt5B.jodun.dy7nDohpepMOUccOge1B4YB8/nGVyOC"
/// name : "test"
/// phone : "+201111111111"
/// avaterId : 1
/// _id : "6920c2c0162367cc49c6b670"
/// createdAt : "2025-11-21T19:51:28.406Z"
/// updatedAt : "2025-11-21T19:51:28.406Z"
/// __v : 0

