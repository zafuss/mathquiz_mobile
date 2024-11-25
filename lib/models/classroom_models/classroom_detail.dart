import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom_role.dart';
import 'package:mathquiz_mobile/models/client.dart';

class ClassroomDetail extends Equatable {
  final String id;
  final ClassroomRole classroomRole;
  final Classroom classroom;
  final Client client;

  const ClassroomDetail({
    required this.id,
    required this.classroomRole,
    required this.classroom,
    required this.client,
  });
  factory ClassroomDetail.fromJson(Map<String, dynamic> json) =>
      ClassroomDetail(
        id: json['id'],
        classroomRole: json['classroomRole'],
        classroom: json['classroom'],
        client: json['client'],
      );
  @override
  // TODO: implement props
  List<Object?> get props => [id, classroomRole, classroom, client];
}
