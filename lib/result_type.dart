sealed class ResultType<T> {}

class Success<T> extends ResultType<T> {
  Success(this.data);

  final T data;
}

class Failure<T> extends ResultType<T> {
  Failure(this.message);

  final String message;
}
