class LoginSuccessDto {
  final String id;
  final DateTime createDate;
  final String? avatarUrl;
  final String email;
  final String? fullName;

  const LoginSuccessDto(
      {required this.id,
      required this.createDate,
      this.avatarUrl,
      required this.email,
      this.fullName});

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) {
    return LoginSuccessDto(
        id: json['id'] as String,
        createDate: DateTime.parse(json['createDate']),
        avatarUrl: json['avatarUrl'],
        fullName: json['fullName'],
        email: json['email'] as String);
  }
}
