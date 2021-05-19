/// An [Exception] thrown when an error or process failure is detected.
class ContentfulProcessingFailedException implements Exception {
  final String _message;
  final Object? _cause;
  final StackTrace? _stacktrace;

  ContentfulProcessingFailedException(String message,
      {Object? cause, StackTrace? stacktrace}): _message = message, _cause = cause, _stacktrace = stacktrace;

  /// Details related to the cause of the [Exception] thrown.
  String get message => _message;

  /// The actual exception thrown that caused the process to fail.
  Object? get cause => _cause;

  /// The [StackTrace] for the actual [Exception] that caused the error to be thrown.
  StackTrace? get stacktrace => _stacktrace;
}