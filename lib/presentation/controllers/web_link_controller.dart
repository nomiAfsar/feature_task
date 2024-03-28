import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:links_feature/data/models/web_links_model.dart';
import 'package:links_feature/data/repositories/links_repository/web_link_repository.dart';

class WeblinkController extends GetxController{
  var list = <WebLinksModel>[].obs;

  RxList<WebLinksModel> getData(Box<WebLinksModel> box)  {
    list = WebLinkRepository.getDataFromDB(box).obs;
    update();
    return list;
  }

}