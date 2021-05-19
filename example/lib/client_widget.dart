import 'package:contentful_sdk/clients/core.dart';
import 'package:contentful_sdk/exceptions/contentful_processing_failed.dart';
import 'package:contentful_sdk/exceptions/contentful_request_failed.dart';
import 'package:contentful_sdk/models/contentful_content_type_field.dart';
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
  dynamic _resultEntries = '';
  dynamic _resultContentTypes = '';
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

  /// Wraps the async [Function] in a way to prevent app from breaking.
  Future<void> _safelyHandleAsyncFunction(
      Future<void> Function() action) async {
    try {
      await action();
    } on ContentfulRequestFailedException catch (error) {
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

    String items = '';
    results.items.forEach((item) {
      items += '${item.fields.toString()}';
    });
    setState(
        () => _resultContentTypes = _buildContentTypeResults(results.items));
  }

  Widget _buildContentTypeResults(List<ContentfulItem> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items
          .map<Widget>(
            (item) => ExpansionTile(
              title: Text(item.name ?? 'n/a'),
              leading: Icon(Icons.info),
              children: [
                Container(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Type',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Required',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Disabled',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Omitted',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Localized',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: List<ContentfulContentTypeField>.from(item.fields)
                            .map<DataRow>((field) => DataRow(
                                  cells: [
                                    DataCell(Text(field.id)),
                                    DataCell(Text(field.name)),
                                    DataCell(Text(field.type)),
                                    DataCell(Text('${field.required}')),
                                    DataCell(Text('${field.disabled}')),
                                    DataCell(Text('${field.omitted}')),
                                    DataCell(Text('${field.localized}')),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildEntryResults(List<ContentfulItem> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items
          .map<Widget>((item) => ExpansionTile(
                leading: Container(
                  width: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.blueGrey,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.contentType?.id ?? 'N/A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(item.id),
                children: [
                  DataTable(
                      columns: [
                        DataColumn(label: Text('Field')),
                        DataColumn(label: Text('Value')),
                      ],
                      rows: (item.fields as Map<String, dynamic>)
                          .entries
                          .map<DataRow>((field) => DataRow(cells: [
                                DataCell(Text(field.key)),
                                DataCell(Text(field.value.toString()))
                              ]))
                          .toList())
                ],
              ))
          .toList(),
    );
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

    String items = '';
    results.items.forEach((item) {
      items += '${item.fields.toString()}';
    });

    setState(() => _resultEntries = _buildEntryResults(results.items));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableCard(
          title: 'Content Type',
          httpMethod: HttpMethod.GET,
          onSend: () async =>
              await _safelyHandleAsyncFunction(_updateContentTypes),
          response: _resultContentTypes,
        ),
        ExpandableCard(
          title: 'Entries',
          httpMethod: HttpMethod.GET,
          onSend: () async => await _safelyHandleAsyncFunction(_updateEntries),
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
