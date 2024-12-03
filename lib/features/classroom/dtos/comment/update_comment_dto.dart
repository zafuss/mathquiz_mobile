class UpdateCommentDto {
  final String id;

  final String content;

  const UpdateCommentDto({
    required this.id,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
      };
}
