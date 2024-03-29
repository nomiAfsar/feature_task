import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:links_feature/data/models/web_links_model.dart';
import 'package:links_feature/data/repositories/links_repository/web_link_repository.dart';

import '../../core/utils/constants.dart';

class WeblinkController extends GetxController{
  var list = <WebLinksModel>[].obs;
  var validateUrlTitle = false.obs;
  var validateURl =false.obs;
  var urlDataType = "".obs;

  void setUrlType(String urlType){
    urlDataType = urlType.obs;
    update();
  }

  void getData() async {
    var box =  await Hive.openBox<WebLinksModel>(hiveBoxName);
    list = box.values.toList().obs;
    box.close();
    update();
  }

  Future<void> deleteData(int id) async {
    final box = await Hive.openBox(hiveBoxName);
    box.delete(id);
    await box.close();
    getData();
  }

  void validateUrlTitleFun(bool titleValidation){
    validateUrlTitle = titleValidation.obs;
    update();
  }


  void validateUrlFun(bool urlValidation){
    validateURl = urlValidation.obs;
    update();
  }

}