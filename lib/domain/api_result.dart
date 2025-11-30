abstract class Result<T> {}

class Success<T> extends Result<T> {
  T data;

  Success(this.data);
}

class Failure<T> extends Result<T> {
  Exception exception;

  Failure(this.exception);
}
