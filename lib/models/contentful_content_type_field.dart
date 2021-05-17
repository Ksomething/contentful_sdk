import 'package:contentful_sdk/models/contentful_field.dart';

class ContentfulContentTypeField extends ContentfulField{
  final String id;
  final String name;
  final String type;
  final bool localized;
  final bool required;
  final List<dynamic> validations;
  final bool disabled;
  final bool omitted;

  ContentfulContentTypeField(this.id, this.name, this.type, this.localized, this.required, this.validations, this.disabled, this.omitted);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'type': type,
    'localized': localized,
    'required': required,
    'validations': validations,
    'disabled': disabled,
    'omitted': omitted,
  };

  factory ContentfulContentTypeField.fromJson(Map<String, dynamic> json) {
    final String _id = json['id'];
    final String _name = json['name'];
    final String _type = json['type'];
    final bool _localized = json['localized'];
    final bool _required = json['required'];
    final List<dynamic> _validations = json['validations'];
    final bool _disabled = json['disabled'];
    final bool _omitted = json['omitted'];
    return ContentfulContentTypeField(_id, _name, _type, _localized, _required, _validations, _disabled, _omitted);
  }
}

enum FieldType {
  String,
  Node,
}

extension ToString on FieldType {
  String get value => this.toString().split('.').last;
}
