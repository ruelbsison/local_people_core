import '../exceptions/server_exception.dart';

class ServerResponse<T> {
  ServerException _error;
  T data;

  setException(ServerException error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  get getException {
    return _error;
  }
}