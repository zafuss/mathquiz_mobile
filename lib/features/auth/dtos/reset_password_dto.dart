class ResetPasswordDto {
  final String email;
  final String otp;
  final String password;

  ResetPasswordDto(
      {required this.email, required this.otp, required this.password});

  Map<String, dynamic> toJson() =>
      {'email': email, 'otp': otp, 'password': password};
}
