/// Exception thrown when the Contentful API returns a failed request
class ContentfulRequestFailedException implements Exception {
  int _statusCode;
  String _url;
  String _methodType;
  Map<String, dynamic>? _body;
  Map<String, String>? _requestHeaders;

  ContentfulRequestFailedException(
      {required int statusCode,
      required String url,
      required String methodType,
      Map<String, dynamic>? body,
      Map<String, String>? requestHeaders})
      : _statusCode = statusCode,
        _url = url,
        _methodType = methodType,
        _body = body,
        _requestHeaders = requestHeaders;

  /// The status code thrown by the API
  int get statusCode => _statusCode;

  /// The URL of the API request
  String get url => _url;

  /// The HTTP Method type of the API request
  String get methodType => _methodType;

  /// The body of the response from the request
  Map<String, dynamic>? get body => _body;

  /// The headers that were sent to the API service.
  Map<String, String>? get requestHeaders => _requestHeaders;
}
