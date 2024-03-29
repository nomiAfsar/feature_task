import 'package:hive/hive.dart';
part 'web_links_model.g.dart';

@HiveType(typeId: 1)
class WebLinksModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String url="";

  @HiveField(2)
  String urlTitle;

  @HiveField(3)
  String socialMediaType;

  WebLinksModel({required this.id, required this.socialMediaType,required this.urlTitle, required this.url});
}
