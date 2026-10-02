class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException(super.message) : super(statusCode: 429);
}

class InvalidDataException extends AppException {
  const InvalidDataException(super.message);
}
