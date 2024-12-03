class CreateNewsDto {
  final String title;
  final String content;
  final String classroomId;
  const CreateNewsDto(
      {required this.title, required this.content, required this.classroomId});

  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'classroomId': classroomId};
}
