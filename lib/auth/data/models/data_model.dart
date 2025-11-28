import 'package:movie_app/auth/domain/entities/user_entity.dart';

class DataModel {
  DataModel({
    this.id,
    this.email,
    this.password,
    this.confirmPassword,
    this.name,
    this.phone,
    this.avaterId,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      confirmPassword: json["confirmPassword"] ?? "",
      avaterId: json["avaterId"] ?? 0,
    );
  }

  String? id;
  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  String? phone;
  num? avaterId;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    return map;
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      name: name ?? '',
      email: email ?? '',
      password: password ?? '',
      confirmPassword: confirmPassword ?? '',
      phone: phone ?? '',
      avaterId: avaterId?.toInt() ?? 0,
    );
  }
}
