import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links_feature/core/utils/constants.dart';
import 'package:links_feature/data/models/web_links_model.dart';
import 'package:path_provider/path_provider.dart' as  path_provider;
import 'package:links_feature/presentation/views/feature_view/main_features_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WebLinksModelAdapter());
  var box = await Hive.openBox(hiveBoxName);
  WebLinksModel dataModel = WebLinksModel(
      url: "www.google.com",
      urlTitle: "Google", id: 0, socialMediaType: '');
  box.add(dataModel);
  print(box.getAt(0).url);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const FeatureView(),
    );
  }
}


