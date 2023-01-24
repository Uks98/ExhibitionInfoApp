import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationClass{
  static var longitude = 126.9779683;
  static var latitude = 37.566535;

  void getLocation(BuildContext context) async {
    try{
      LocationPermission per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied ||
          per == LocationPermission.deniedForever) {
        toastMessage(context,"위치를 허용해주세요");
        LocationPermission per1 = await Geolocator.requestPermission();
      } else {
        Position currentLoc = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("ax${currentLoc.longitude}");

        longitude = currentLoc.longitude;
        latitude = currentLoc.latitude;

        toastMessage(context, "정보를 불러왔습니다.",);
      }
    }catch(e){
      longitude = double.parse("37.566535");
      latitude = double.parse("126.9779683");
     toastMessage(context, "위치를 못가져왔어요");
      print("error123 ${e}");
    }
    }

  void toastMessage(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),backgroundColor: Colors.black,));
  }
}
