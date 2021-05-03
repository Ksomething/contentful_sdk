import 'constants.dart';
import 'delivery.dart';
import 'package:http/http.dart';

class ContentfulPreviewClient extends ContentfulDeliveryClient {
  ContentfulPreviewClient({
    required accessToken,
    required String spaceId,
    String? host,
    String? environment,
    Client? httpClient,
  }) : super(
      accessToken: accessToken,
      spaceId: spaceId,
      host: host ?? DEFAULT_HOST_PREVIEW,
      environment: environment,
      httpClient: httpClient);
}