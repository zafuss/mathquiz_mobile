class ApiCustomException implements Exception {
  ApiCustomException({required this.message, this.statusCode});

  final String message;
  int? statusCode;
}
