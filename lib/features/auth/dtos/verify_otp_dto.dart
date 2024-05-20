class VerifyOtpDto {
  final String userId;
  final String otp;

  VerifyOtpDto({
    required this.userId,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'otp': otp,
      };
}
