import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';

class News extends Equatable {
  final String id;
  final String title;
  final String content;
  final Classroom classroom;
  final DateTime timeCreated;
  final bool isDeleted;

  const News(
      {required this.id,
      required this.title,
      required this.content,
      required this.classroom,
      required this.timeCreated,
      required this.isDeleted});
  factory News.fromJson(Map<String, dynamic> json) => News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      classroom: Classroom.fromJson(json['classroom']),
      timeCreated: DateTime.parse(json['timeCreated']),
      isDeleted: json['isDeleted']);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, content, classroom, timeCreated, isDeleted];
}
