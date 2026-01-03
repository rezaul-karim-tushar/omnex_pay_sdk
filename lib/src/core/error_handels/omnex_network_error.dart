class OmnexNetworkError implements Exception {
  final String message;
  final Object? cause;


  OmnexNetworkError(this.message, [this.cause]);

  @override
  String toString() => "OmnexNetworkError: {message: $message, cause: $cause}";
}

