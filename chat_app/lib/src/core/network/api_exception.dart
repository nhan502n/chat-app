class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic rawBody;

  ApiException(this.statusCode, this.message, [this.rawBody]);

  @override
  String toString() =>
      'ApiException($statusCode): $message${rawBody != null ? ' | $rawBody' : ''}';
}
