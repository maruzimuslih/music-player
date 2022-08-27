import 'package:flutter/material.dart';
import 'package:music_player/home/widgets/home_page.dart';
import 'package:music_player/service_locator.dart';

void main() {
  runApp(const MyApp());
  initServiceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
