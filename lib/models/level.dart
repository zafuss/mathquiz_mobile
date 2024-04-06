import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Level> courtFromJson(String str) =>
    List<Level>.from(json.decode(str).map((x) => Level.fromJson(x)));

class Level extends Equatable {
  Level({required this.id, required this.name});
  final int id;
  final String name;

  static List<Level> levelList = [
    Level(id: 1, name: "Tiểu học"),
    Level(id: 2, name: 'Trung học cơ sở'),
    Level(id: 3, name: 'Trung học phổ thông')
  ];

  factory Level.fromJson(Map<String, dynamic> json) =>
      Level(id: json['id'], name: json['name']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
