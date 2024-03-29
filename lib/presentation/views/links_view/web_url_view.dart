import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links_feature/presentation/controllers/web_link_controller.dart';

import '../../../core/utils/utility.dart';


class URLView extends StatefulWidget {
  const URLView({super.key});
  @override
  State<URLView> createState() => _URLViewState();
}

class _URLViewState extends State<URLView> {
  var webLinksData = [];
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(WeblinkController());
    controller.getData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
    body: GetBuilder<WeblinkController>(builder: (linksController) => getLinksList(linksController)));
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(linkController.list[index].urlTitle),
                            Text(linkController.list[index].url)


                          ],
                        ),
                      ),
                      IconButton(onPressed: (){
                        print(linkController.list[index].socialMediaType);
                        linkController.setUrlType(linkController.list[index].socialMediaType);
                        Utility.showBottomSheet(context,linkController.list[index] , true);

                      }, icon: const Icon(Icons.edit_note, color: Colors.green,)),
                      IconButton(onPressed: (){
                              linkController.deleteData(linkController.list[index].id);
                      }, icon: const Icon(Icons.delete, color: Colors.red,)),

                    ],
                  ),
                ),
              ),
            );

        },
      );
    }
  }

}
