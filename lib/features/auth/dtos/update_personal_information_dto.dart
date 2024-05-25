class UpdatePersonalInformationDto {
  final String id;
  final String? fullName;
  final String? phoneNumber;
  final int? gradeId;

  UpdatePersonalInformationDto(
      {required this.id, this.fullName, this.phoneNumber, this.gradeId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'gradeId': gradeId
      };
}
