class ContentfulProperty {
  final String? id;
  final String? type;
  final String? linkType;
  ContentfulProperty({this.id, this.type, this.linkType});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sys': {
          if (type != null) 'type': type,
          if (linkType != null) 'linkType': linkType,
          if (id != null) 'id': id,
        }
      };

  factory ContentfulProperty.fromJson(Map<String, dynamic> json) {
    final content = json['sys'] as Map<String, dynamic>;
    final String? responseId = content.containsKey('id') ? content['id'] : null;
    final String? responseType =
        content.containsKey('type') ? content['type'] : null;
    final String? responseLinkType =
        content.containsKey('linkType') ? content['linkType'] : null;
    return ContentfulProperty(
        id: responseId, type: responseType, linkType: responseLinkType);
  }
}
