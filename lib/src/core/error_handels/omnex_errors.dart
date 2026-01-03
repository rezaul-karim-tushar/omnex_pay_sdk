class OmnexApiErrors implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? body;

  OmnexApiErrors({
    required this.statusCode,
    required this.message,
    this.body,
  });


  @override
  String toString() => "OmnexApiErrors: {statusCode: $statusCode, message: $message, body: $body}";
}

