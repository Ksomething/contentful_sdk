import 'package:contentful_sdk/clients/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String _title;
  final HttpMethod _httpMethod;
  final dynamic? _response;
  final Function() _onSend;

  ExpandableCard({
    required String title,
    required HttpMethod httpMethod,
    required Function() onSend,
    dynamic? response,
  })  : _title = title,
        _httpMethod = httpMethod,
        _onSend = onSend,
        _response = response;

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  Widget _buildTitle(String title, HttpMethod method) {
    late Color methodColor;
    late Color methodTextColor;
    switch (method) {
      case HttpMethod.GET:
        methodColor = Colors.blueAccent;
        methodTextColor = Colors.white;
        break;
      case HttpMethod.POST:
        methodColor = Colors.deepOrange;
        methodTextColor = Colors.white;
        break;
      case HttpMethod.PATCH:
        methodColor = Colors.grey;
        methodTextColor = Colors.black;
        break;
      case HttpMethod.PUT:
        methodColor = Colors.deepPurple;
        methodTextColor = Colors.white;
        break;
      case HttpMethod.DELETE:
        methodColor = Colors.red;
        methodTextColor = Colors.white;
        break;
      default:
        methodColor = Colors.teal;
        methodTextColor = Colors.white;
        break;
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: methodColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                method.value,
                style: TextStyle(
                  color: methodTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ExpansionTile(
          title: _buildTitle(widget._title, widget._httpMethod),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget._httpMethod != HttpMethod.GET)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: widget._onSend, child: Text('SEND')),
                        ],
                      ),
                      Text(
                        'Response',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Response',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: widget._onSend, child: Text('SEND')),
                    ],
                  ),
            (widget._response == null)
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Nothing to show yet!'),
                  )
                : (widget._response is String)
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(widget._response),
                      )
                    : Container(child: widget._response),
          ],
        ),
      ),
    );
  }
}
