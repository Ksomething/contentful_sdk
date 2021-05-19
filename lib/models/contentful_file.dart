class ContentfulFile {
  final String url;
  final String name;
  final String contentType;
  final double size;
  final int? width;
  final int? height;

  ContentfulFile({
    required this.url,
    required this.name,
    required this.contentType,
    required this.size,
    this.width,
    this.height,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'details': {
          'size': size,
          if (contentType.contains('image'))
            'image': {
              'width': width,
              'height': height,
            },
          'fileName': name,
          'contentType': contentType,
        },
      };

  factory ContentfulFile.fromJson(Map<String, dynamic> json) {
    final String responseUrl = json['url'];
    final String responseName = json['fileName'];
    final String responseContentType = json['contentType'];
    final double responseSize = (json['details'])['size'];
    final int? responseWidth = (responseContentType.contains('image'))
        ? ((json['details'])['image'])['width']
        : null;
    final int? responseHeight = (responseContentType.contains('image'))
        ? ((json['details'])['image'])['height']
        : null;
    return ContentfulFile(
      url: responseUrl,
      name: responseName,
      contentType: responseContentType,
      size: responseSize,
      width: responseWidth,
      height: responseHeight,
    );
  }
}
