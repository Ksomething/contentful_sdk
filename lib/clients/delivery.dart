import 'package:contentful_sdk/clients/core.dart';
import 'package:contentful_sdk/clients/constants.dart';
import 'package:contentful_sdk/exceptions/contentful_processing_failed.dart';
import 'package:contentful_sdk/exceptions/contentful_request_failed.dart';
import 'package:contentful_sdk/models/contentful_content_type_field.dart';
import 'package:contentful_sdk/models/contentful_response.dart';
import 'package:http/http.dart';

class ContentfulDeliveryClient extends CoreClient {
  ContentfulDeliveryClient({
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

  Future<ContentfulResponse> getEntries(
      {T Function<T>(Map<String, dynamic>)? mapFromJson}) async {
    try {
      final json = await handleRequest(path: '/entries');
      return ContentfulResponse.fromJson(json, mapFromJson: mapFromJson);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the entries.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> getSpace(
      {T Function<T>(Map<String, dynamic>)? mapFromJson}) async {
    try {
      final json = await handleRequest(path: '', includeEnvironment: false);
      return ContentfulResponse.fromJson(json, mapFromJson: mapFromJson);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the space.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> getAssets(
      {T Function<T>(Map<String, dynamic>)? mapFromJson}) async {
    try {
      final json = await handleRequest(path: '/assets');
      return ContentfulResponse.fromJson(json, mapFromJson: mapFromJson);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the entries.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> getAsset(String assetId,
      {T Function<T>(Map<String, dynamic>)? mapFromJson}) async {
    try {
      final json = await handleRequest(path: '/assets/$assetId');
      return ContentfulResponse.fromJson(json, mapFromJson: mapFromJson);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the entries.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> getContentTypes() async {
    List<ContentfulContentTypeField> mapResponse(
            List<Map<String, dynamic>> json) =>
        json.map<ContentfulContentTypeField>(
              (field) => ContentfulContentTypeField.fromJson(field),
        ).toList();

    try {
      final json = await handleRequest(path: '/content_types');
      return ContentfulResponse.fromJson(json, mapFromJson: mapResponse);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the entries.',
          cause: error,
          stacktrace: stacktrace);
    }
  }
}
