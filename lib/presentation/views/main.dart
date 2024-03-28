import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links_feature/presentation/views/feature_view/main_features_view.dart';

void main() {
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


