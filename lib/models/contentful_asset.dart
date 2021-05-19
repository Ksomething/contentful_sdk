import 'package:contentful_sdk/models/contentful_file.dart';
import 'package:contentful_sdk/models/contentful_metadata.dart';
import 'package:contentful_sdk/models/contentful_property.dart';

class ContentfulAsset {
  final ContentfulMetadata metadata;
  final ContentfulProperty space;
  final String id;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ContentfulProperty environment;
  final int revision;
  final String locale;
  final ContentfulFile file;
  final String title;
  final String description;

  ContentfulAsset(
    this.metadata,
    this.space,
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.environment,
    this.revision,
    this.locale,
    this.file,
    this.title,
    this.description,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'metadata': metadata.toJson(),
        'sys': {
          'space': space.toJson(),
          'id': id,
          'type': type,
          'createdAt': createdAt.toIso8601String(),
          'updatedAt': updatedAt.toIso8601String(),
          'environment': environment.toJson(),
          'revision': revision,
          'locale': locale,
        },
        'fields': {
          'title': title,
          'description': description,
          'file': file.toJson(),
        }
      };

  factory ContentfulAsset.fromJson(Map<String, dynamic> json) {
    final ContentfulMetadata _metadata = ContentfulMetadata.fromJson(json['metadata']);
    final Map<String, dynamic> _content = json['sys'];
    final ContentfulProperty _space = ContentfulProperty.fromJson(_content['space']);
    final String _id = _content['id'];
    final String _type = _content['type'];
    final DateTime _createdAt = DateTime.parse(_content['createdAt']);
    final DateTime _updatedAt = DateTime.parse(_content['updatedAt']);
    final ContentfulProperty _environment = ContentfulProperty.fromJson(_content['environment']);
    final int _revision = _content['revision'];
    final String _locale = _content['locale'];
    final Map<String, dynamic> _fields = json['fields'];
    final String _title = _fields['title'];
    final String _description = _fields['description'];
    final ContentfulFile _file = ContentfulFile.fromJson(_fields['file']);
    return ContentfulAsset(_metadata, _space, _id, _type, _createdAt, _updatedAt,
        _environment, _revision, _locale, _file, _title, _description);
  }
}
