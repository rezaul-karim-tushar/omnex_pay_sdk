

class OmnexUnknownError implements Exception {
   final String message;
   OmnexUnknownError(this.message);

   @override
   String toString() => "OmnexUnknownError: {message: $message}";
}

