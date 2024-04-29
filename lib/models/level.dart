import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Level> levelFromJson(String str) {
  return List<Level>.from(json.decode(str).map((x) {
    return Level.fromJson(x);
  }));
}

class Level extends Equatable {
  const Level({required this.id, required this.name});
  final int id;
  final String name;

  static List<Level> levelList = [
    const Level(id: 1, name: "Tiểu học"),
    const Level(id: 2, name: 'Trung học cơ sở'),
    const Level(id: 3, name: 'Trung học phổ thông')
  ];

  factory Level.fromJson(Map<String, dynamic> json) =>
      Level(id: json['id'], name: json['name']);
  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
