class RegisterDto {
  final String email;
  final String password;
  final String fullName;
  final int gradeId;

  RegisterDto(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.gradeId});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'fullName': fullName,
        'gradeId': gradeId
      };
}
