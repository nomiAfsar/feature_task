import 'package:flutter/material.dart';
import 'package:links_feature/core/utils/constants.dart';
import 'package:links_feature/core/utils/utility.dart';
import 'package:links_feature/presentation/views/empty_view/empty_feature_view.dart';
import 'package:links_feature/presentation/views/links_view/web_url_view.dart';

class FeatureView extends StatefulWidget {
  const FeatureView({super.key});

  @override
  State<FeatureView> createState() => _FeatureViewState();
}

class _FeatureViewState extends State<FeatureView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(featureAppTitle),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Utility.showBottomSheet(context);
      }, child:  const Icon(Icons.add)),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.line_style),
            icon: Icon(Icons.list_rounded),
            label: 'Empty',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.list_alt_outlined)),
            selectedIcon: Icon(Icons.featured_play_list_outlined),
            label: 'URL',
          ),
        ],
      ),
      body: const <Widget>[
        EmptyView(),
        URLView()
      ][currentPageIndex],

    );

  }
}
