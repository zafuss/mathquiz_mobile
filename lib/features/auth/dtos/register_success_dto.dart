class RegisterSuccessDto {
  final String id;
  final DateTime createDate;
  final String? avatarUrl;
  final String email;
  final String? fullName;
  final int gradeId;

  const RegisterSuccessDto(
      {required this.id,
      required this.createDate,
      this.avatarUrl,
      required this.email,
      this.fullName,
      required this.gradeId});

  factory RegisterSuccessDto.fromJson(Map<String, dynamic> json) {
    return RegisterSuccessDto(
        id: json['id'] as String,
        createDate: DateTime.parse(json['createDate']),
        avatarUrl: json['avatarUrl'],
        fullName: json['fullName'],
        email: json['email'] as String,
        gradeId: json['gradeId'] as int);
  }
}
