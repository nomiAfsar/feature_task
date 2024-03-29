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
      builder: (BuildContext builderContext) => Padding(
        padding: MediaQuery.of(context).viewInsets,
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
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              'Add URL',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              )),
                        ),
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
                            labelStyle:  TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,

                            ),
                          ),
                          style:  TextStyle(
                            color:Colors.black.withOpacity(0.4),
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
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(emojiRegexp))],
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
                            if(urlTitleController.text.isEmpty){
                              webLinkController.validateUrlTitleFun(true);
                              return;
                            }else if (urlController.text.isEmpty){
                              webLinkController.validateUrlFun(true);
                              return;
                            }else{
                              if(isEdit){
                                updateData(webLinkController, webLinksModel);
                              }else{
                                insertData(webLinkController);

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
              )),
        ),
      ),
    );
  }
  static void insertData(WeblinkController weblinkController) async {
    final box = await Hive.openBox<WebLinksModel>(hiveBoxName);
    int nextId = await _getNextId(box);
    box.put(nextId, WebLinksModel(url: urlController.text, urlTitle: urlTitleController.text, id: nextId,socialMediaType: "Google"));
    await box.close();
    weblinkController.getData();
    Get.back();
  }

  static void updateData(WeblinkController weblinkController, WebLinksModel weblinkModel) async {
    final box = await Hive.openBox<WebLinksModel>(hiveBoxName);
    box.put(weblinkModel.id, WebLinksModel(url: urlController.text, urlTitle: urlTitleController.text, id: weblinkModel.id,socialMediaType: "Google"));
    await box.close();
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

}