class UserModel {
  final String? id;
  final String? email;
  final String? token;

  UserModel({
    this.id,
    this.email,
    this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      email: json['email'],
      token: json['token'],
    );
  }
}

