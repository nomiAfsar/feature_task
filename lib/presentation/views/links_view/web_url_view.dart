import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links_feature/presentation/controllers/web_link_controller.dart';


class URLView extends StatefulWidget {
  const URLView({super.key});
  @override
  State<URLView> createState() => _URLViewState();
}

class _URLViewState extends State<URLView> {
  var webLinksData = [];
  @override
  Widget build(BuildContext context) {
    Get.put(WeblinkController());
    return GetBuilder<WeblinkController>(builder: (linksController) => getLinksList(linksController));
  }

  Widget getLinksList(WeblinkController linkController){
    if(linkController.list.isEmpty){
      return const Center(child: Text('No Record Found'));
    }else{
      return ListView.separated(
        itemCount: linkController.list.length,
        separatorBuilder: (context, build) =>  Container() ,
        itemBuilder: (context,index){
          return
             Card(
              elevation: 0,
              child: Padding(
                padding:  const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Values is ${linkController.list[index].url}')
                  ],
                ),
              ),
            );

        },
      );
    }
  }

}
