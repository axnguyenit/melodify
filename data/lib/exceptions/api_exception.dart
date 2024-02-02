class ApiException implements Exception {
  final String _message;
  final String? _prefix;

  ApiException(this._message, [this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }

  String get errorMessage => '$_prefix$_message';
}

class FetchDataException extends ApiException {
  FetchDataException(String message)
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 'Unauthorized: ');
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message, 'Not Found: ');
}

class ServerErrorException extends ApiException {
  ServerErrorException(String message) : super(message, 'Server Error: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException(String message) : super(message, 'Invalid Input: ');
}

class InvalidResponseException extends ApiException {
  InvalidResponseException(String message)
      : super(message, 'Invalid Response: ');
}
