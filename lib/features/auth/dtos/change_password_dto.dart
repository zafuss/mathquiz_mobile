class ChangepasswordDto {
  final String userId;
  final String currentPassword;
  final String newPassword;

  ChangepasswordDto(
      {required this.userId,
      required this.currentPassword,
      required this.newPassword});

  Map<String, dynamic> toJson() => {
        'id': userId,
        'currentPassword': currentPassword,
        'newPassword': newPassword
      };
}
