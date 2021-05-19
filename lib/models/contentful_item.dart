import 'package:contentful_sdk/models/contentful_metadata.dart';
import 'package:contentful_sdk/models/contentful_property.dart';

class ContentfulItem {
  final ContentfulProperty space;
  final ContentfulMetadata? metadata;
  final String id;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ContentfulProperty environment;
  final int? publishedVersion;
  final DateTime? publishedAt;
  final DateTime? firstPublishedAt;
  final ContentfulProperty? createdBy;
  final ContentfulProperty? updatedBy;
  final int? publishedCounter;
  final int? version;
  final ContentfulProperty? publishedBy;
  final int? revision;
  final String? displayField;
  final String? name;
  final String? description;
  final ContentfulProperty? contentType;
  final String? locale;
  final dynamic fields;

  ContentfulItem(
      this.space,
      this.metadata,
      this.id,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.environment,
      this.publishedVersion,
      this.publishedAt,
      this.firstPublishedAt,
      this.createdBy,
      this.updatedBy,
      this.publishedCounter,
      this.version,
      this.publishedBy,
      this.revision,
      this.displayField,
      this.name,
      this.description,
      this.contentType,
      this.locale,
      this.fields);

  factory ContentfulItem.fromJson(Map<String, dynamic> json,
      {Function? mapFromJson}) {
    final Map<String, dynamic> _content = json['sys'];
    final _space = ContentfulProperty.fromJson(_content['space']);
    final _metadata = json.containsKey('metadata')
        ? ContentfulMetadata.fromJson(json['metadata'])
        : null;
    final String _id = _content['id'];
    final String _type = _content['type'];
    final _contentType = _content.containsKey('contentType')
        ? ContentfulProperty.fromJson(_content['contentType'])
        : null;
    final _createdAt = DateTime.parse(_content['createdAt']);
    final _updatedAt = DateTime.parse(_content['updatedAt']);
    final _environment = ContentfulProperty.fromJson(_content['environment']);
    final int? _publishedVersion = _content['publishedVersion'];
    final DateTime? _publishedAt = _content.containsKey('publishedAt')
        ? DateTime.parse(_content['publishedAt'])
        : null;
    final DateTime? _firstPublishedAt = _content.containsKey('firstPublishedAt')
        ? DateTime.parse(_content['firstPublishedAt'])
        : null;
    final _createdBy = _content.containsKey('createdBy')
        ? ContentfulProperty.fromJson(_content['createdBy'])
        : null;
    final _updatedBy = _content.containsKey('updatedBy')
        ? ContentfulProperty.fromJson(_content['updatedBy'])
        : null;
    final int? _publishedCounter = _content['publishedCounter'];
    final int? _version = _content['version'];
    final ContentfulProperty? _publishedBy = _content.containsKey('publishedBy')
        ? ContentfulProperty.fromJson(_content['publishedBy'])
        : null;
    final int? _revision = _content['revision'];
    final String? _displayField = json['displayField'];
    final String? _name = json['name'];
    final String? _description = json['description'];
    final String? _locale = _content['locale'];
    final _fields = (mapFromJson == null)
        ? json['fields']
        : mapFromJson(List<Map<String, dynamic>>.from(json['fields']));

    return ContentfulItem(
        _space,
        _metadata,
        _id,
        _type,
        _createdAt,
        _updatedAt,
        _environment,
        _publishedVersion,
        _publishedAt,
        _firstPublishedAt,
        _createdBy,
        _updatedBy,
        _publishedCounter,
        _version,
        _publishedBy,
        _revision,
        _displayField,
        _name,
        _description,
        _contentType,
        _locale,
        _fields);
  }
}
