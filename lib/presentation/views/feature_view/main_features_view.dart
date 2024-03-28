import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links_feature/core/utils/constants.dart';
import 'package:links_feature/core/utils/utility.dart';
import 'package:links_feature/presentation/controllers/feature_controller.dart';
import 'package:links_feature/presentation/views/empty_view/empty_feature_view.dart';
import 'package:links_feature/presentation/views/links_view/web_url_view.dart';

class FeatureView extends StatefulWidget {
  const FeatureView({super.key});

  @override
  State<FeatureView> createState() => _FeatureViewState();
}

class _FeatureViewState extends State<FeatureView> {
  @override
  Widget build(BuildContext context) {
    Get.put(FeatureController());
    return GetBuilder<FeatureController>(builder: (featureController) => Scaffold(
        appBar: AppBar(
          title: const Text(featureAppTitle),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Utility.showBottomSheet(context);
        }, child:  const Icon(Icons.add)),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            featureController.updateCurrentPage(index);
          },
          indicatorColor: Colors.amber,
          selectedIndex: featureController.currentPageIndex.value,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Badge(child: Icon(Icons.list_alt_outlined)),
              selectedIcon: Icon(Icons.featured_play_list_outlined),
              label: 'URL',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.line_style),
              icon: Icon(Icons.list_rounded),
              label: 'Empty',
            ),

          ],
        ),
        body: const <Widget>[
          URLView(),
          EmptyView(),
        ][featureController.currentPageIndex.value]
    ));

  }
}
