class RegisterDto {
  final String email;
  final String password;
  final String fullName;

  RegisterDto(
      {required this.email, required this.password, required this.fullName});

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'fullName': fullName};
}
