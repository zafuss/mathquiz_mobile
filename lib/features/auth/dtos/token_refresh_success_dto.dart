class TokenRefreshSuccessDto {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String fullName;
  final String email;
  final String? imageUrl;
  final String? phoneNumber;
  final int? gradeId;
  TokenRefreshSuccessDto({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.fullName,
    required this.email,
    this.imageUrl,
    this.phoneNumber,
    this.gradeId,
  });

  factory TokenRefreshSuccessDto.fromJson(Map<String, dynamic> json) {
    return TokenRefreshSuccessDto(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      gradeId: json['gradeId'],
      phoneNumber: json['phoneNumber'],
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
