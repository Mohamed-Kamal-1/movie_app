  class UserInfo {
  String? name;
  String? email;


  UserInfo._internal();


  static final UserInfo _instance = UserInfo._internal();


  factory UserInfo() => _instance;

  String? getName() => name;

  String? getEmail() => email;

  void setUser(String name, String email) {
    if (name.trim().isEmpty || email.trim().isEmpty) return;
    this.name = name;
    this.email = email;
  }
}