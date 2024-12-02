import 'package:equatable/equatable.dart';

class Classroom extends Equatable {
  final String id;
  final String? name;
  final DateTime createDate;
  final DateTime? endDate;
  final String? teacherFullName;
  final int numOfMembers;

  const Classroom(
      {required this.id,
      this.name,
      required this.createDate,
      this.endDate,
      required this.teacherFullName,
      required this.numOfMembers});
  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
      id: json['id'],
      name: json['name'],
      createDate: DateTime.parse(json['createDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      teacherFullName: json['teacherFullName'],
      numOfMembers: json['numOfMembers']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, createDate, endDate];
}
