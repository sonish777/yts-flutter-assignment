import 'package:flutter/material.dart';
import 'package:flutter_assingment_2/screens/home/home.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: Home(), debugShowCheckedModeBanner: false);
  }
}
