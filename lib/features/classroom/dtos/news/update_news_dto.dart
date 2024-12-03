class UpdateNewsDto {
  final String id;
  final String title;
  final String content;
  final bool isDeleted;

  const UpdateNewsDto({
    required this.id,
    required this.title,
    required this.content,
    required this.isDeleted,
  });

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content, 'isDeleted': isDeleted};
}
