import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class  MainInfoPage extends StatelessWidget {
  MainInfoPage({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _GoogleMapCamera; //상세 페이지의 마커
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(width: 400,height: 600,color: Colors.black,),
          SlidingUpPanel(
            panelBuilder: (ScrollController sc) => _scrollingList(sc),
            body: Center(
              child: Text("This is the Widget behind the sliding panel"),
            ),
          ),
      ],
      ),
    );
  }
  Widget _scrollingList(ScrollController sc){
    return ListView.builder(
      controller: sc,
      itemCount: _normalInfoController.mainExhibitionList.length,
      itemBuilder: (BuildContext context, int i){
        final exIndex = _normalInfoController.mainExhibitionList[i];
        return Container(
          padding: const EdgeInsets.all(12.0),
          child: MainExhibitionView(
            imageUrl: exIndex.thumb.toString(),
              name: exIndex.title.toString(),
            location: exIndex.place.toString()
          ),
        );
      },
    );
  }
}

Widget MainExhibitionView({required String imageUrl, required String name, required String location}){
  return Container(
    child: Row(
      children: [
        Image.network(imageUrl,width: 100,height: 100,fit: BoxFit.cover,),
        Column(
          children: [
            Text(name),
            Text(location),
          ],
        )
      ],
    ),
  );
}