import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/client.dart';

class Classroom extends Equatable {
  final String id;
  final String? name;
  final DateTime createDate;
  final DateTime? endDate;
  final Client? teacher;
  final int numOfMembers;

  const Classroom(
      {required this.id,
      this.name,
      required this.createDate,
      this.endDate,
      this.teacher,
      required this.numOfMembers});
  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
      id: json['id'],
      name: json['name'],
      createDate: DateTime.parse(json['createDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      teacher:
          json['teacher'] != null ? Client.fromJson(json['teacher']) : null,
      numOfMembers: json['numOfMembers']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, createDate, endDate, teacher];
}
