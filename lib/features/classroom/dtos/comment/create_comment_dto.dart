class CreateCommentDto {
  final String content;
  final String newsId;
  final String clientId;
  const CreateCommentDto(
      {required this.newsId, required this.content, required this.clientId});

  Map<String, dynamic> toJson() =>
      {'newsId': newsId, 'content': content, 'clientId': clientId};
}
