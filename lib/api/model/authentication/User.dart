
import '../../../domain/model/entities/user_entity.dart';

class User {
  User({this.name, this.email});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
  }

  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    return map;
  }

  UserEntity convertIntoUserEntity() {
    return UserEntity(name: name ?? '', email: email ?? '');
  }
}
