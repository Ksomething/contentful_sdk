import 'package:contentful_sdk/clients/core.dart';
import 'package:contentful_sdk/exceptions/contentful_processing_failed.dart';
import 'package:contentful_sdk/exceptions/contentful_request_failed.dart';
import 'package:contentful_sdk/models/contentful_response.dart';
import 'package:contentful_sdk_example/expandable_card.dart';
import 'package:contentful_sdk_example/support.dart';
import 'package:contentful_sdk/contentful_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentfulWidget extends StatefulWidget {
  final ContentfulServiceType _serviceType;
  final String _accessToken;
  final String _spaceId;
  final String _environment;
  final String? _host;

  ContentfulWidget({
    ContentfulServiceType serviceType = ContentfulServiceType.Delivery,
    required String accessToken,
    required String spaceId,
    required String environment,
    String? host,
  })  : _serviceType = serviceType,
        _accessToken = accessToken,
        _spaceId = spaceId,
        _environment = environment,
        _host = host;

  @override
  State<StatefulWidget> createState() => _ContentfulWidgetState(
        accessToken: _accessToken,
        spaceId: _spaceId,
        environment: _environment,
        host: _host,
        serviceType: _serviceType,
      );
}

class _ContentfulWidgetState extends State<ContentfulWidget> {
  late final contentfulClient;
  String _resultEntries = '';
  String _resultContentTypes = '';
  String _resultCreateContentType = '';
  String _resultCreateEntry = '';

  _ContentfulWidgetState({
    ContentfulServiceType serviceType = ContentfulServiceType.Delivery,
    required String accessToken,
    required String spaceId,
    required String environment,
    String? host,
  }) {
    switch (serviceType) {
      case ContentfulServiceType.Preview:
        contentfulClient = ContentfulPreviewClient(
          accessToken: accessToken,
          spaceId: spaceId,
          environment: environment,
          host: host,
        );
        break;
      case ContentfulServiceType.Management:
        contentfulClient = ContentfulManagementClient(
          accessToken: accessToken,
          spaceId: spaceId,
          environment: environment,
          host: host,
        );
        break;
      default:
        contentfulClient = ContentfulDeliveryClient(
          accessToken: accessToken,
          spaceId: spaceId,
          environment: environment,
          host: host,
        );
        break;
    }
  }

  Future<void> _safelyHandleAsyncFunction(Future<void> Function() action) async {
    try {
      await action();
    }on ContentfulRequestFailedException catch (error) {
      final message = (error.body != null)
          ? error.body!['message'] as String
          : 'Request Failed';
      final errorMsg = '$message. (Error Code: ${error.statusCode})';
      print('[${error.methodType}] ${error.url}');
      print('Status Code: ${error.statusCode}');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMsg)));
    } on ContentfulProcessingFailedException catch (error) {
      print('Plugin failed to parse response');
      print('${error.cause}\n${error.stacktrace}');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.deepOrange,
      ));
    } catch (error, stacktrace) {
      final errorMsg =
          'Something went wrong while trying to send your request.';

      print('An unexpected error.');
      print('$error\n$stacktrace');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMsg),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  Future<void> _updateContentTypes() async {
      late final ContentfulResponse results;

      switch (widget._serviceType) {
        case ContentfulServiceType.Delivery:
          final client = contentfulClient as ContentfulDeliveryClient;
          results = await client.getContentTypes();
          break;
        case ContentfulServiceType.Preview:
          final client = contentfulClient as ContentfulPreviewClient;
          results = await client.getContentTypes();
          break;
        case ContentfulServiceType.Management:
          final client = contentfulClient as ContentfulManagementClient;
          results = await client.getContentTypes();
          break;
      }
      setState(() => _resultContentTypes = results.toString());
  }

  Future<void> _updateEntries() async {
    late final ContentfulResponse results;

    switch (widget._serviceType) {
      case ContentfulServiceType.Delivery:
        final client = contentfulClient as ContentfulDeliveryClient;
        results = await client.getEntries();
        break;
      case ContentfulServiceType.Preview:
        final client = contentfulClient as ContentfulPreviewClient;
        results = await client.getEntries();
        break;
      case ContentfulServiceType.Management:
        final client = contentfulClient as ContentfulManagementClient;
        results = await client.getEntries();
        break;
    }

    setState(() => _resultEntries = results.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableCard(
          title: 'Content Type',
          httpMethod: HttpMethod.GET,
          onSend: () async => await _safelyHandleAsyncFunction(_updateContentTypes),
          response: _resultContentTypes,
        ),
        ExpandableCard(
          title: 'Entries',
          httpMethod: HttpMethod.GET,
          onSend: () async => await _safelyHandleAsyncFunction(_updateEntries) ,
          response: _resultEntries,
        ),
        if (widget._serviceType == ContentfulServiceType.Management)
          Column(
            children: [
              ExpandableCard(
                title: 'Content Type',
                httpMethod: HttpMethod.POST,
                onSend: () {},
              ),
            ],
          ),
      ],
    );
  }
}
