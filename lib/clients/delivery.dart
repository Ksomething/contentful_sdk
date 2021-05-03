import 'package:contentful_sdk/clients/client_core.dart';
import 'package:contentful_sdk/clients/constants.dart';
import 'package:http/http.dart';

class ContentfulClient extends CoreClient {
  ContentfulClient({
    required accessToken,
    required String spaceId,
    String? host,
    String? environment,
    Client? httpClient,
  }) : super(
            accessToken: accessToken,
            spaceId: spaceId,
            host: host ?? DEFAULT_HOST_DELIVERY,
            environment: environment,
            httpClient: httpClient);


  Future<Map<String, dynamic>> getEntries() async {
    return await handleRequest(path: '/entries');
  }

  Future<Map<String, dynamic>> getSpace() async {
    return await handleRequest(path: '', includeEnvironment: false);
  }

  Future<Map<String, dynamic>> getAssets() async {
    return await handleRequest(path: '/assets');
  }

  Future<Map<String, dynamic>> getAsset(String assetId) async {
    return await handleRequest(path: '/assets/$assetId');
  }

  Future<Map<String, dynamic>> getContentTypes() async {
    return await handleRequest(path: '/content_types');
  }
}
