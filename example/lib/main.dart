import 'package:contentful_sdk_example/client_widget.dart';
import 'package:contentful_sdk_example/support.dart';
import 'package:contentful_sdk/contentful_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contentful SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Contentful SDK Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerSpaceId;
  late TextEditingController _controllerEnvironment;
  late TextEditingController _controllerAccessToken;
  late TextEditingController _controllerHost;

  ContentfulServiceType? _selectedServiceType = ContentfulServiceType.Delivery;
  Widget? _contentfulWidget;

  final double _formfieldPadding = 10.0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerAccessToken = TextEditingController(text: '');
    _controllerEnvironment = TextEditingController(text: 'master');
    _controllerSpaceId = TextEditingController(text: '');
    _controllerHost = TextEditingController();
  }

  String? _fieldValidator(String? value) {
    return (value != null && value.length > 0) ? null : 'Cannot be empty';
  }

  void _buildContentfulWidget() {
    print('Contentful Credentials provided: '
        '(Access Token: ${_controllerAccessToken.text})-'
        '(Space ID: ${_controllerSpaceId.text})-'
        '(Environment: ${_controllerEnvironment.text})');

    if (_formKey.currentState!.validate()) {
      setState(() {
        _contentfulWidget = ContentfulWidget(
          accessToken: _controllerAccessToken.text,
          spaceId: _controllerSpaceId.text,
          environment: _controllerEnvironment.text,
          host: (_controllerHost.text.length > 0) ? _controllerHost.text : null,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(),
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Client Builder',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(_formfieldPadding),
                              child: TextFormField(
                                controller: _controllerSpaceId,
                                decoration:
                                    InputDecoration(labelText: 'Space ID'),
                                validator: _fieldValidator,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(_formfieldPadding),
                              child: TextFormField(
                                controller: _controllerEnvironment,
                                decoration:
                                    InputDecoration(labelText: 'Environment'),
                                validator: _fieldValidator,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(_formfieldPadding),
                              child: TextFormField(
                                controller: _controllerAccessToken,
                                decoration:
                                    InputDecoration(labelText: 'Access Token'),
                                validator: _fieldValidator,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(_formfieldPadding),
                        child: TextFormField(
                          controller: _controllerHost,
                          decoration:
                              InputDecoration(labelText: 'Host (Optional)'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(_formfieldPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Contentful API Service Type',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<ContentfulServiceType>(
                                    title: Text('Delivery'),
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    value: ContentfulServiceType.Delivery,
                                    groupValue: _selectedServiceType,
                                    onChanged: (value) {
                                      setState(
                                          () => _selectedServiceType = value);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<ContentfulServiceType>(
                                    title: Text('Preview'),
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    value: ContentfulServiceType.Preview,
                                    groupValue: _selectedServiceType,
                                    onChanged: (value) {
                                      setState(
                                          () => _selectedServiceType = value);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<ContentfulServiceType>(
                                    title: Text('Management'),
                                    dense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    value: ContentfulServiceType.Management,
                                    groupValue: _selectedServiceType,
                                    onChanged: (value) {
                                      setState(
                                          () => _selectedServiceType = value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _buildContentfulWidget();
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('Build', style: TextStyle(fontSize: 18.0)),
                            SizedBox(width: _formfieldPadding),
                            Icon(Icons.handyman),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_contentfulWidget != null) _contentfulWidget!,
          ],
        ),
      ),
    );
  }
}
