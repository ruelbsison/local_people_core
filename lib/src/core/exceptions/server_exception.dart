import 'package:dio/dio.dart' hide Headers;

class InternetConnectionException implements Exception{}

class ServerException implements Exception {
  int _errorCode;
  String _errorMessage = "";

  ServerException.withError({DioError error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    if (error.response == null)
      return;

    _errorCode = error.response.statusCode;
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.DEFAULT:
        _errorMessage =
        "Connection failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.RESPONSE:
        _errorMessage =
        "Received invalid status code: ${error.response.statusCode} : ${error.response.statusMessage}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }
}