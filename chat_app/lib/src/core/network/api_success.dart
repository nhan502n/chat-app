class ApiSuccess<T> {
  final int statusCode;
  final String message;
  final T? data;
  final dynamic rawBody;

  ApiSuccess({
    required this.statusCode,
    required this.message,
    this.data,
    this.rawBody,
  });

  @override
  String toString() =>
      'ApiSuccess($statusCode): $message${rawBody != null ? ' | $rawBody' : ''}';
}
