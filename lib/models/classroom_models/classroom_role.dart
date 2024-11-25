import 'package:equatable/equatable.dart';

class ClassroomRole extends Equatable {
  final String id;
  final String name;

  const ClassroomRole({
    required this.id,
    required this.name,
  });
  factory ClassroomRole.fromJson(Map<String, dynamic> json) => ClassroomRole(
        id: json['id'],
        name: json['name'],
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
      ];
}
