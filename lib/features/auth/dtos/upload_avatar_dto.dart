class UploadAvatarDto {
  final String userId;
  String? imageUrl;

  UploadAvatarDto({
    required this.userId,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': userId,
        'avatarUrl': imageUrl,
      };
}
