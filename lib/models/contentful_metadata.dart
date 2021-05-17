import 'package:contentful_sdk/models/contentful_property.dart';

class ContentfulMetadata {
  final List<ContentfulProperty> tags;

  ContentfulMetadata(this.tags);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tags': tags.map((tag) => tag.toJson()).toList(),
      };

  factory ContentfulMetadata.fromJson(Map<String, dynamic> json) {
    final List<ContentfulProperty> responseTags = (json['tags'])
        .map<ContentfulProperty>((raw) => ContentfulProperty.fromJson(raw))
        .toList();
    return ContentfulMetadata(responseTags);
  }
}
