import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MVC/View/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false ,
      title: 'Flutter Demo',
      builder: (context,child)=>MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0)
        , child: child!,),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "cusNormal"
      ),
      home: BottomNavigationPage(),
    );
  }
}
