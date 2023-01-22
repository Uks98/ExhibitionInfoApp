import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seoul_exhibition_info/MVC/Controller/map_controller.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/View/bottom_navigation.dart';
import 'package:seoul_exhibition_info/MVC/View/main_info_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class  BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _GoogleMapCamera;

  //상세 페이지의 마커
  int _currentIndex = 0; // 바텀 네비게이션 현재 index
  List<Widget> appPages = [
    MainInfoPage(),
    LocationPage(),
    Text("data"),
    Text("data"),
  ]; // 앱 화면들

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ],
      ),
      body: appPages.elementAt(_currentIndex),
    );
  }

}