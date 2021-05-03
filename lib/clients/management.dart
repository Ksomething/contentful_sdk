import 'package:contentful_sdk/clients/client_contentful.dart';
import 'package:contentful_sdk/clients/client_core.dart';
import 'package:contentful_sdk/clients/constants.dart';
import 'package:http/http.dart';

class ContentfulManagementClient extends ContentfulClient {
  ContentfulManagementClient({
    required accessToken,
    required String spaceId,
    String? host,
    String? environment,
    Client? httpClient,
  }) : super(
            accessToken: accessToken,
            spaceId: spaceId,
            host: host ?? DEFAULT_HOST_MANAGEMENT,
            environment: environment,
            httpClient: httpClient);

  Future<Map<String, dynamic>> createEntry(String contentfulContentType, dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_MANAGEMENT,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
    };
    return await handleRequest(path: '/entries', methodType: HttpMethod.POST, headers: headers, body: body,);
  }

  Future<Map<String, dynamic>> patchEntry(String entryId, String contentfulContentType, int contentfulEntryVersion, dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_PATCH,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
      HEADER_CONTENTFUL_VERSION: '$contentfulEntryVersion',
    };
    return await handleRequest(path: '/entries/$entryId', methodType: HttpMethod.PATCH, headers: headers, body: body,);
  }

  Future<Map<String, dynamic>> updateEntry(String entryId, String contentfulContentType, int contentfulEntryVersion, dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_PATCH,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
      HEADER_CONTENTFUL_VERSION: '$contentfulEntryVersion',
    };
    return await handleRequest(path: '/entries/$entryId', methodType: HttpMethod.PATCH, headers: headers, body: body,);
  }
}
