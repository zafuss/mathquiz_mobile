import 'package:equatable/equatable.dart';
import 'package:mathquiz_mobile/models/classroom_models/news.dart';
import 'package:mathquiz_mobile/models/client.dart';

class Comment extends Equatable {
  final String id;
  final String content;
  final News news;
  final DateTime publishDate;
  final Client client;

  const Comment(
      {required this.id,
      required this.content,
      required this.news,
      required this.publishDate,
      required this.client});
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      id: json['id'],
      content: json['content'],
      news: News.fromJson(json['news']),
      publishDate: DateTime.parse(json['publishDate']),
      client: Client.fromJson(json['client']));
  @override
  // TODO: implement props
  List<Object?> get props => [id, content, news, publishDate, client];
}
