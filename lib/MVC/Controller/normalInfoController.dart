import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:xml2json/xml2json.dart';

import '../Model/ExhibitionData.dart';


class NormalInfoController extends GetxController{
  var mainExhibitionList = <Exhibition>[].obs;

  getJsonFromXMLUrl(String url) async{
    final Xml2Json xml2Json = Xml2Json();
    try {
      var response = await http.get(Uri.parse(url));
      xml2Json.parse(utf8.decode(response.bodyBytes));
      var jsonString = xml2Json.toParker();
      return jsonDecode(jsonString);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Exhibition>> returnJson({required String startDay,required String endDay,String row = "10",required String place,String sorts = "1",required String keyword})async{
    var data = await getJsonFromXMLUrl("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?from=$startDay&to=$endDay&cPage=1&rows=$row&place=$place&gpsxfrom=&gpsyfrom=&gpsxto=&gpsyto=&keyword=$keyword&sortStdr=$sorts&serviceKey=iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D");
    print(data["response"]["msgBody"]["perforList"] as List);
    var parseData = (data["response"]["msgBody"]["perforList"] as List).map((data) => Exhibition.fromJson(data)).toList();
    print(parseData);
    return parseData;
  }
  void getExhibitionData({required String startDay,required String endDay,String row = "10",required String place,String sorts = "1",required String keyword})async{
    var ex = await returnJson(startDay: startDay,endDay: endDay,place: place,sorts: sorts,keyword: keyword);
    mainExhibitionList.value = ex;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getExhibitionData(startDay: "20221118",endDay: "20230117",place: "",sorts: "1",row: "10", keyword: "전시");
  }
}

