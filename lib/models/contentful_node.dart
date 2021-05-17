class ContentfulNode {
  final String type;
  final Map<String, dynamic> data;
  final List<ContentfulNode>? content;
  final String? value;
  final List<dynamic>? marks;

  ContentfulNode({
    required this.type,
    this.data = const <String, dynamic>{},
    this.content,
    this.value,
    this.marks,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "nodeType": type,
        "data": data,
        if (content != null) "content": content,
        if (value != null) "value": value,
        if (marks != null) "marks": marks,
      };

  factory ContentfulNode.fromJson(Map<String, dynamic> json) {
    final String responseType = json['nodeType'];
    final Map<String, dynamic> responseData = json['data'];
    final List<ContentfulNode>? responseContent = json.containsKey('content')
        ? (json['content'])
            .map<ContentfulNode>((raw) => ContentfulNode.fromJson(raw))
            .toList()
        : null;
    final String? responseValue =
        json.containsKey('value') ? json['value'] : null;
    final List<dynamic> responseMarks =
        json.containsKey('marks') ? json['marks'] : null;
    return ContentfulNode(
        type: responseType,
        data: responseData,
        content: responseContent,
        value: responseValue,
        marks: responseMarks);
  }
}
