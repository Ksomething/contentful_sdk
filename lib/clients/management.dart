import 'package:contentful_sdk/clients/delivery.dart';
import 'package:contentful_sdk/clients/core.dart';
import 'package:contentful_sdk/clients/constants.dart';
import 'package:contentful_sdk/exceptions/contentful_processing_failed.dart';
import 'package:contentful_sdk/exceptions/contentful_request_failed.dart';
import 'package:contentful_sdk/models/contentful_response.dart';
import 'package:http/http.dart';

class ContentfulManagementClient extends ContentfulDeliveryClient {
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

  Future<ContentfulResponse> createEntry(
      String contentfulContentType, dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_MANAGEMENT,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
    };

    try {
      final json = await handleRequest(
        path: '/entries',
        methodType: HttpMethod.POST,
        headers: headers,
        body: body,
      );
      return ContentfulResponse.fromJson(json);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the created entry.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> patchEntry(
      String entryId,
      String contentfulContentType,
      int contentfulEntryVersion,
      dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_PATCH,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
      HEADER_CONTENTFUL_VERSION: '$contentfulEntryVersion',
    };
    try {
      final json = await handleRequest(
        path: '/entries/$entryId',
        methodType: HttpMethod.PATCH,
        headers: headers,
        body: body,
      );
      return ContentfulResponse.fromJson(json);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the patched entry.',
          cause: error,
          stacktrace: stacktrace);
    }
  }

  Future<ContentfulResponse> updateEntry(
      String entryId,
      String contentfulContentType,
      int contentfulEntryVersion,
      dynamic body) async {
    final headers = <String, String>{
      'Content-Type': CONTENT_TYPE_JSON_PATCH,
      HEADER_CONTENTFUL_CONTENT_TYPE: contentfulContentType,
      HEADER_CONTENTFUL_VERSION: '$contentfulEntryVersion',
    };
    try {
      final json = await handleRequest(
        path: '/entries/$entryId',
        methodType: HttpMethod.PATCH,
        headers: headers,
        body: body,
      );
      return ContentfulResponse.fromJson(json);
    } catch (error, stacktrace) {
      if (error is ContentfulRequestFailedException) rethrow;
      throw ContentfulProcessingFailedException(
          'Failed to process the results for the patched entry.',
          cause: error,
          stacktrace: stacktrace);
    }
  }
}
