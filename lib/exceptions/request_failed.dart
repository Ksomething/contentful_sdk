/// Exception thrown when the Contentful API returns a failed request
class ContentfulRequestFailedException implements Exception {
  int _statusCode;
  String _url;
  String _methodType;
  dynamic? _body;

  ContentfulRequestFailedException(
      {required int statusCode,
      required String url,
      required String methodType,
      dynamic? body})
      : _statusCode = statusCode,
        _url = url,
        _methodType = methodType,
        _body = body;

  /// The status code thrown by the API
  int get statusCode => _statusCode;

  /// The URL of the API request
  String get url => _url;

  /// The HTTP Method type of the API request
  String get methodType => _methodType;

  /// The body of the response from the request
  dynamic get body => _body;
}
