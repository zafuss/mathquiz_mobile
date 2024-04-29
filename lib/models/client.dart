import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int id;
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
