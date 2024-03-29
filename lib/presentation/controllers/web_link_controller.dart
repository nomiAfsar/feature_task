import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:links_feature/data/models/web_links_model.dart';
import 'package:links_feature/data/repositories/links_repository/web_link_repository.dart';

import '../../core/utils/constants.dart';

class WeblinkController extends GetxController{
  var list = <WebLinksModel>[].obs;
  var validateUrlTitle = false.obs;
  var validateURl =false.obs;

  void getData() async {
    var box =  await Hive.openBox<WebLinksModel>(hiveBoxName);
    list = box.values.toList().obs;
    update();
  }

  void deleteData(int id){
    update();
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