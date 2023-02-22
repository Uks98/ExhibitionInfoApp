import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';
import 'dart:convert' as convert;

import 'package:xml2json/xml2json.dart';

import '../Model/ExhibitionData.dart';


class LocationDetailController extends GetxController{
  var locationDetailList = <Exhibition>[].obs;
  static var data;

  late BuildContext context;
  DateTime now = DateTime.now().subtract(Duration(days: 30));
  DateTime endNow = DateTime.now();
  String get time => DateFormat("yyyyMMdd").format(now);
  String get endTime => DateFormat("yyyyMMdd").format(endNow);

  getJsonFromXMLUrl(String url) async{
    final Xml2Json xml2Json = Xml2Json();
    try {
      var response = await http.get(Uri.parse(url));
      xml2Json.parse(utf8.decode(response.bodyBytes));
      var jsonString = xml2Json.toParker();
      print("jsonString12 : ${jsonString}");
      return jsonDecode(jsonString);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Exhibition>> returnJson({String sorts = "1",required String keyword})async{
    data = await getJsonFromXMLUrl("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/area?serviceKey=iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D&sido=$keyword&rows=20");
    var parseData = (data["response"]["msgBody"]["perforList"] as List).map((data) => Exhibition.fromJson(data)).toList();
    return parseData;
  }
  void getExhibitionDetailData({String sorts = "1",required String keyword})async{
    var ex = await returnJson(sorts: sorts,keyword: keyword);
    locationDetailList.value = ex;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //LocationClass().getLocation(Get.context!);
    getExhibitionDetailData(sorts: "1", keyword: "");
  }
}

