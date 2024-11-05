class RankingDto {
  final String fullName;
  final double score;
  final String duration;

  const RankingDto(
      {required this.fullName, required this.score, required this.duration});

  factory RankingDto.fromJson(Map<String, dynamic> json) {
    return RankingDto(
      fullName: json['fullName'] as String,
      score: (json['score'] is int)
          ? (json['score'] as int).toDouble()
          : json['score'] as double,
      duration: json['duration'] as String,
    );
  }
}
