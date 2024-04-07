import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Grade> gradeFromJson(String str) =>
    List<Grade>.from(json.decode(str).map((x) => Grade.fromJson(x)));

class Grade extends Equatable {
  Grade({required this.id, required this.name, required this.levelId});
  final int id;
  final String name;
  final int levelId;

  static List<Grade> gradeList = [
    Grade(id: 1, name: "Lớp 1", levelId: 1),
    Grade(id: 2, name: 'Lớp 2', levelId: 1),
    Grade(id: 3, name: 'Lớp 3', levelId: 1),
    Grade(id: 4, name: "Lớp 4", levelId: 1),
    Grade(id: 5, name: 'Lớp 5', levelId: 1),
    Grade(id: 6, name: 'Lớp 6', levelId: 2),
    Grade(id: 7, name: "Lớp 7", levelId: 2),
    Grade(id: 8, name: 'Lớp 8', levelId: 2),
    Grade(id: 9, name: 'Lớp 9', levelId: 2),
    Grade(id: 10, name: "Lớp 10", levelId: 3),
    Grade(id: 11, name: 'Lớp 11', levelId: 3),
    Grade(id: 12, name: 'Lớp 12', levelId: 3),
  ];

  factory Grade.fromJson(Map<String, dynamic> json) =>
      Grade(id: json['id'], name: json['name'], levelId: json['levelId']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, levelId];
}
