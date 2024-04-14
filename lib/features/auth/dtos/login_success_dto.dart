class LoginSuccessDto {
  final String id;
  final DateTime createDate;
  final String? avatarUrl;
  final String email;

  const LoginSuccessDto({
    required this.id,
    required this.createDate,
    this.avatarUrl,
    required this.email,
  });

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) {
    return LoginSuccessDto(
        id: json['id'] as String,
        createDate: DateTime.parse(json['createDate']),
        avatarUrl: json['avatarUrl'],
        email: json['email'] as String);
  }
}
