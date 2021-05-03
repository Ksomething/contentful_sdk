import 'package:contentful_sdk/exceptions/request_failed.dart';
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
  serviceType: _serviceType,);
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

  Future<void> _updateContentTypes() async {
    try {
      late final Map<String, dynamic> results;

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
    } catch(error, stacktrace) {
      late final errorMsg;
      if (error is ContentfulRequestFailedException) {
        final message = (error.body != null) ? error.body!['message'] as String: 'Request Failed';
        errorMsg = '$message. (Error Code: ${error.statusCode})';
        print('[${error.methodType}] ${error.url}');
        print('Status Code: ${error.statusCode}');
      } else {
        errorMsg = 'Something went wrong while trying to send your request.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

  Future<void> _updateEntries() async {
    late final Map<String, dynamic> results;

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
    return Card(
      shape: RoundedRectangleBorder(),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async => await _updateContentTypes(),
                    child: Text('Get Content Type'),
                  ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_resultContentTypes),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async => await _updateEntries(),
                    child: Text('Get Entries'),
                  ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_resultEntries),
                    ),
                  ),
                ),
              ],
            ),

            if (widget._serviceType == ContentfulServiceType.Management)
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Create Content Type'),
                  ),
                ],
              ),
            if (widget._serviceType == ContentfulServiceType.Management)
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Create Entry'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
