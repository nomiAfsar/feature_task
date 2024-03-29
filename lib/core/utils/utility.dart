import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:links_feature/data/models/web_links_model.dart';
import 'package:links_feature/presentation/controllers/web_link_controller.dart';

import 'constants.dart';

class Utility{
  static TextEditingController urlController = TextEditingController();
  static TextEditingController urlTitleController = TextEditingController();

  static void showBottomSheet(BuildContext context, WebLinksModel webLinksModel, bool isEdit) {
    if(isEdit){
      urlController.text = webLinksModel.url;
      urlTitleController.text = webLinksModel.urlTitle;
    }else{
      urlController.clear();
      urlTitleController.clear();
    }
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (BuildContext builderContext) => getEditSheet(isEdit,context,webLinksModel),
    );
  }
  static void insertData(WeblinkController weblinkController) async {
    final box = await Hive.openBox<WebLinksModel>(hiveBoxName);
    int nextId = await _getNextId(box);
    box.put(nextId, WebLinksModel(url: urlController.text, urlTitle: urlTitleController.text, id: nextId,socialMediaType: weblinkController.urlDataType.value));
    await box.close();
    urlTitleController.clear();
    urlController.clear();
    weblinkController.getData();
    Get.back();
  }

  static void updateData(WeblinkController weblinkController, WebLinksModel weblinkModel) async {
    final box = await Hive.openBox<WebLinksModel>(hiveBoxName);
    box.put(weblinkModel.id, WebLinksModel(url: urlController.text, urlTitle: urlTitleController.text, id: weblinkModel.id,socialMediaType: "Google"));
    await box.close();
    urlTitleController.clear();
    urlController.clear();
    weblinkController.getData();
    Get.back();
  }
  static Future<int> _getNextId(Box<WebLinksModel> box) async {
    int latestId = 0;
    if (box.isNotEmpty) {
      final latestItem = box.values.reduce((curr, next) =>
      (curr.id > next.id) ? curr : next);
      latestId = latestItem.id;
    }
    return latestId + 1;
  }

  static String getImageUrl(String title){
    if(title == "facebook"){
      return 'assets/images/facebook.png';
    }else if (title == "instagram"){
      return 'assets/images/instagram.png';
    }else if(title == "tiktok"){
      return 'assets/images/tiktok.png';
    }else{
      return 'assets/images/others.png';
    }
  }

  static Widget getImages(String socialMediaType){
    if(socialMediaType.isNotEmpty) {
      return Image(image: AssetImage(getImageUrl(socialMediaType)),
    height: 50,
    width: 50,);
    }else {
      return Container();
    }
  }

  static bool isValidUrl(String value) {
    String urlRegexExp =  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?)';
    RegExp urlRegex = RegExp(
      urlRegexExp,
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegex.hasMatch(value);
  }

  static Widget getEditSheet(bool isEdit, BuildContext context, WebLinksModel webLinksModel){
    if(isEdit){
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: getNewSheet(isEdit,context, webLinksModel),
      );
    }else{
      return getNewSheet(isEdit,context, webLinksModel);
    }
  }

  static Widget getNewSheet(bool isEdit,BuildContext context, WebLinksModel webLinksModel){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 20,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GetBuilder<WeblinkController>(builder: (weblinkController) => getImages(weblinkController.urlDataType.value)),
                  InkWell(
                    child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 30,
                        child: const Icon(Icons.cancel)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child:  const Text(
                    urlTitleLabel,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
              ),
              GetBuilder<WeblinkController>(builder: (webLinkController) =>  Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 5),
                  child:TextField(
                    controller: urlTitleController,
                    maxLines: null,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(emojiRegexp))],
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      errorText: webLinkController.validateUrlTitle.value ? urlTitleErrorText: null,
                      border:  const OutlineInputBorder(),
                      enabledBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            width: 1.0),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            width: 1.0),
                      ),
                      fillColor: Colors.white,
                      hintText: urlTitleHint,
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,

                      ),
                    ),
                    style:  const TextStyle(
                      color:Colors.black,
                      fontSize: 12,
                    ),
                    onChanged: (value){
                      if (value.isEmpty) {
                        webLinkController.validateUrlTitleFun(true);
                        urlErrorText = "Please Enter Url Title";
                      } else {
                        webLinkController.validateUrlTitleFun(false);
                        urlErrorText = "";
                      }
                    },
                  )),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child:  const Text(
                    urlLabel,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
              ),
              GetBuilder<WeblinkController>(builder: (webLinkController) => Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 5),
                  child:TextField(
                    controller: urlController,
                    maxLength: 25,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      errorText: webLinkController.validateURl.value ? urlErrorText: null,
                      border:  const OutlineInputBorder(),
                      enabledBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            width: 1.0),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.5),
                            width: 1.0),
                      ),
                      fillColor: Colors.white,
                      hintText: urlTitleHint,
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      labelStyle:  TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,

                      ),
                    ),
                    style: const TextStyle(
                      color:Colors.black,
                      fontSize: 12,
                    ),
                    onChanged: (value){
                      if (value.isEmpty) {
                        webLinkController.validateUrlFun(true);
                        urlErrorText = "Please Enter Url";
                      } else {
                        webLinkController.validateUrlFun(false);
                        if(value.contains('facebook')){
                          webLinkController.setUrlType("facebook");
                        }else if(value.contains('instagram')){
                          webLinkController.setUrlType("instagram");
                        }else if(value.contains('tiktok')){
                          webLinkController.setUrlType("tiktok");
                        }else{
                          webLinkController.setUrlType("others");
                        }
                        urlErrorText = "";
                      }
                    },
                  ))),

              GetBuilder<WeblinkController>(builder: (webLinkController) =>  Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        disabledForegroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(double.infinity, 45)),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(urlTitleController.text.isEmpty){
                        webLinkController.validateUrlTitleFun(true);
                        return;
                      }else if (urlController.text.isEmpty){
                        webLinkController.validateUrlFun(true);
                        return;
                      }else if(!isValidUrl(urlController.text)){
                        urlErrorText = "Invalid URL";
                        webLinkController.validateURl(true);
                        return;
                      }else{
                        if(isEdit){
                          updateData(webLinkController, webLinksModel);
                        }else{
                          var listSize =webLinkController.list.length;
                          if(listSize > 2){
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  maxItemError,
                                  textAlign: TextAlign.center,
                                  style:   TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            );
                          }else{
                            insertData(webLinkController);
                          }

                        }
                      }
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        saveLabel,
                        style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }


}