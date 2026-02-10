class APIError {
  static const String SERVER_FAILURE = 'Server Failure';
  static const String CACHE_FAILURE = 'Cache Failure';
  static const String UNEXPECTED_ERROR = 'Unexpected Error';
  static const String NO_INTERNET = 'Internet connection not available';
}

class ModelException implements Exception {
  final String message;
  ModelException(this.message);

  @override
  String toString() {
    return "We're having trouble processing your request. Please try again later.$message";
  }
}

