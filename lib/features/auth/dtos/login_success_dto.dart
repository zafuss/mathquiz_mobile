class LoginSuccessDto {
  final String id;
  final DateTime createDate;
  final String? avatarUrl;
  final String email;
  final String? fullName;
  final String accessToken;
  final String refreshToken;
  final String? phoneNumber;
  final int? gradeId;

  const LoginSuccessDto(
      {required this.id,
      required this.createDate,
      this.avatarUrl,
      required this.email,
      this.fullName,
      required this.accessToken,
      required this.refreshToken,
      this.phoneNumber,
      this.gradeId});

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) {
    return LoginSuccessDto(
        id: json['id'] as String,
        createDate: DateTime.parse(json['createDate']),
        avatarUrl: json['avatarUrl'],
        fullName: json['fullName'],
        email: json['email'] as String,
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        phoneNumber: json['phoneNumber'],
        gradeId: json['gradeId']);
  }
}
