class UserEntity {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;
  final String id;



  UserEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.avaterId,
    required this.id,
    required this.confirmPassword,
  });
}