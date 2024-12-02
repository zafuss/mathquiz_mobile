import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;
  final String? username;
  final String? fullname;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;
  final DateTime? createDate;
  final DateTime? updateDate;
  final DateTime? activeDate;

  const Client(
      {required this.id,
      this.username,
      this.fullname,
      required this.email,
      this.phoneNumber,
      this.imageUrl,
      this.createDate,
      this.updateDate,
      this.activeDate});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json['id'],
        username: json['username'],
        fullname: json['fullName'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        imageUrl: json['avatarUrl'],
        activeDate: json['activeDate'] != null
            ? DateTime.parse(json['activeDate'])
            : null,
        createDate: json['createDate'] != null
            ? DateTime.parse(json['createDate'])
            : null,
        updateDate: json['updateDate'] != null
            ? DateTime.parse(json['updateDate'])
            : null,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        username,
        fullname,
        email,
        phoneNumber,
        imageUrl,
        createDate,
        updateDate,
        activeDate
      ];
}
