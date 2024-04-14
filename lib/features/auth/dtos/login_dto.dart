class LoginDto {
  final String email;
  final String password;
  final bool rememberMe;
  const LoginDto(
      {required this.email, required this.password, required this.rememberMe});

  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'rememberMe': rememberMe};
}
