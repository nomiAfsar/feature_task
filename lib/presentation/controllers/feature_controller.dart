import 'package:get/get.dart';

class FeatureController extends GetxController{
  var currentPageIndex = 0.obs;

  void updateCurrentPage(int index){
    currentPageIndex = index.obs;
    update();
  }
}