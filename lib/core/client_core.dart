import 'package:contentful_sdk/exceptions/request_failed.dart';
import 'package:http/http.dart';
import 'package:contentful_sdk/core/constants.dart';
import 'dart:convert';

/// Singleton instance of a HTTP Client fitted for Contentful requests
class CoreClient extends BaseClient {
  final Client _client;
  final String _accessToken;
  final String _spaceId;
  final String _environment;
  final String _host;

  CoreClient(
      {required String accessToken,
      required String spaceId,
      required String host,
      String? environment,
      Client? httpClient})
      : _accessToken = accessToken,
        _spaceId = spaceId,
        _host = host,
        _environment = environment ?? DEFAULT_ENVIRONMENT,
        _client = httpClient ?? Client();

  Uri getPath(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool includeEnvironment = true,
  }) =>
      Uri(
        scheme: 'https',
        host: _host,
        path: (includeEnvironment)
            ? '/space/$_spaceId/environments/$_environment$path'
            : '/space/$_spaceId$path',
        queryParameters: queryParameters,
      );

  void close() {
    _client.close();
  }

  Future<Map<String, dynamic>> handleRequest({
    required String path,
    HttpMethod methodType = HttpMethod.GET,
    Map<String, String>? headers,
    dynamic? body,
    bool includeEnvironment = true,
  }) async {

    final api = getPath(path, includeEnvironment: includeEnvironment);
    late final response;

    switch (methodType) {
      case HttpMethod.POST:
        response = await _client.post(api, headers: headers, body: body);
        break;
      case HttpMethod.PATCH:
        response = await _client.patch(api, headers: headers, body: body);
        break;
      case HttpMethod.PUT:
        response = await _client.put(api, headers: headers, body: body);
        break;
      case HttpMethod.DELETE:
        response = await _client.delete(api, headers: headers, body: body);
        break;
      default:
        response = await _client.get(api, headers: headers);
        break;
    }

    if (response.statusCode >= 400) {
      throw ContentfulRequestFailedException(
        statusCode: response.statusCode,
        url: api.toString(),
        methodType: '$methodType',
        body: jsonDecode(response.body),
      );
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $_accessToken';
    return _client.send(request);
  }
}

enum HttpMethod {
  GET,
  POST,
  PATCH,
  PUT,
  DELETE,
}
