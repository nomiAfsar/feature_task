import 'package:hive_flutter/hive_flutter.dart';
import 'package:links_feature/data/models/web_links_model.dart';


class WebLinkRepository{

  static List<WebLinksModel> getDataFromDB(Box<WebLinksModel> box) {
    var items = box.values.toList().reversed.toList() ;
    return items;
  }
}