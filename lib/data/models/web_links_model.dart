import 'package:hive/hive.dart';
part 'web_links_model.g.dart';

@HiveType(typeId: 1)
class WebLinksModel {
  @HiveField(0)
  String url="";

  @HiveField(1)
  String urlTitle;

  WebLinksModel({required this.urlTitle, required this.url});
}
