import 'package:contentful_sdk/models/contentful_asset.dart';
import 'package:contentful_sdk/models/contentful_item.dart';

class ContentfulResponse {
  final String type;
  final int total;
  final int skip;
  final int limit;
  final List<ContentfulItem> items;
  final List<ContentfulAsset> assets;

  ContentfulResponse(
      this.type, this.total, this.skip, this.limit, this.items, this.assets);

  factory ContentfulResponse.fromJson(Map<String, dynamic> json,
      {Function? mapFromJson}) {
    final String _type = (json['sys'] as Map<String, dynamic>)['type'];
    final int _total = json['total'];
    final int _skip = json['skip'];
    final int _limit = json['limit'];
    final List<ContentfulItem> _items = json['items']
        .map<ContentfulItem>(
            (raw) => ContentfulItem.fromJson(raw, mapFromJson: mapFromJson))
        .toList();
    final List<ContentfulAsset> _assets = json.containsKey('includes')
        ? ((json['includes'])['Asset'])
            .map<ContentfulAsset>((raw) => ContentfulAsset.fromJson(raw))
            .toList()
        : [];
    return ContentfulResponse(_type, _total, _skip, _limit, _items, _assets);
  }
}
