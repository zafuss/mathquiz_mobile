import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Chapter> chapterFromJson(String str) =>
    List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

class Chapter extends Equatable {
  Chapter(
      {required this.id,
      required this.name,
      this.mathTypeId,
      required this.gradeId});
  final int id;
  final String name;
  final int? mathTypeId;
  final int gradeId;

  static List<Chapter> chapterList = [
    Chapter(id: 1, name: "Chương 1", gradeId: 1),
    Chapter(id: 2, name: 'Chương 2', gradeId: 1),
    Chapter(id: 3, name: 'Chương 3', gradeId: 1),
    Chapter(id: 4, name: "Chương 1", gradeId: 2),
    Chapter(id: 5, name: 'Chương 2', gradeId: 2),
    Chapter(id: 6, name: 'Chương 3', gradeId: 2),
    Chapter(id: 7, name: "Chương 1", gradeId: 3),
    Chapter(id: 8, name: 'Chương 2', gradeId: 3),
    Chapter(id: 9, name: 'Chương 1', gradeId: 4),
    Chapter(id: 10, name: "Chương 2", gradeId: 4),
    Chapter(id: 11, name: 'Chương 1', gradeId: 5),
    Chapter(id: 12, name: 'Chương 2', gradeId: 5),
    Chapter(id: 13, name: "Chương 1 đại", gradeId: 6, mathTypeId: 1),
    Chapter(id: 14, name: 'Chương 2 đại', gradeId: 6, mathTypeId: 1),
    Chapter(id: 15, name: 'Chương 1 hình', gradeId: 6, mathTypeId: 2),
    Chapter(id: 16, name: "Chương 1", gradeId: 7, mathTypeId: 1),
    Chapter(id: 17, name: 'Chương 2', gradeId: 7, mathTypeId: 1),
    Chapter(id: 18, name: 'Chương 3', gradeId: 7, mathTypeId: 2),
    Chapter(id: 19, name: "Chương 1", gradeId: 8, mathTypeId: 1),
    Chapter(id: 20, name: 'Chương 2', gradeId: 8, mathTypeId: 2),
    Chapter(id: 21, name: 'Chương 1', gradeId: 9, mathTypeId: 1),
    Chapter(id: 22, name: "Chương 2", gradeId: 9, mathTypeId: 1),
    Chapter(id: 23, name: 'Chương 1', gradeId: 10, mathTypeId: 1),
    Chapter(id: 24, name: 'Chương 2', gradeId: 10, mathTypeId: 2),
    Chapter(id: 25, name: 'Chương 1', gradeId: 11, mathTypeId: 1),
    Chapter(id: 26, name: 'Chương 2', gradeId: 11, mathTypeId: 1),
    Chapter(id: 27, name: 'Chương 1', gradeId: 12, mathTypeId: 2),
    Chapter(id: 28, name: 'Chương 2', gradeId: 12, mathTypeId: 2),
  ];

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'],
      name: json['name'],
      mathTypeId: json['mathTypeId'],
      gradeId: json['levelId']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, mathTypeId, gradeId];
}
