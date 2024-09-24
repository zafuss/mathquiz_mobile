class VerifyOtpDto {
  final String email;
  final String otp;

  VerifyOtpDto({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}
