sealed class ResultType<T> {}

class Success<T> extends ResultType<T> {
  Success(this.data, [this.statusCode]);
  final T data;
  final int? statusCode;
}

class Failure<T> extends ResultType<T> {
  Failure(this.message, [this.statusCode]);
  final String message;
  final int? statusCode;
}
