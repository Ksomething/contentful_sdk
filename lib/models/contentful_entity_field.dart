import 'package:contentful_sdk/models/contentful_node.dart';

import 'contentful_field.dart';

class ContentfulEntityField extends ContentfulField{
  final String name;
  final dynamic value;

  ContentfulEntityField(this.name, this.value);

  @override
  dynamic toJson() {
    return MapEntry<String, dynamic>(name, value);
  }

  factory ContentfulEntityField.fromJson(MapEntry<String, dynamic> record) {
    final String _name = record.key;
    final _value = (record.value is Map<String, dynamic>) ? ContentfulNode.fromJson(record.value): record.value;
    return ContentfulEntityField(_name, _value);
  }

}