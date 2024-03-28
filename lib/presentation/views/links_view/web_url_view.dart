import 'package:flutter/material.dart';

class URLView extends StatefulWidget {
  const URLView({super.key});

  @override
  State<URLView> createState() => _URLViewState();
}

class _URLViewState extends State<URLView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('URL View'),
    );
  }
}
