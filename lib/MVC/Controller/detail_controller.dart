
import 'dart:convert';

import 'package:get/get.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionDetailModel.dart';

class DetailController extends GetxController {
  var detailList = <String>[].obs;
  NormalInfoController normalInfoController = Get.put(NormalInfoController());

  static const String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
  var data;
  Future<List<String>> returnToJson1({required String seq}) async {
    const String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
    //"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key"
    data = await normalInfoController.getJsonFromXMLUrl(
        "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key");
    String title = data["response"]["msgBody"]["perforInfo"]["title"] ?? "";
    String place = data["response"]["msgBody"]["perforInfo"]["place"]?? "";
    String placeAddr = data["response"]["msgBody"]["perforInfo"]["placeAddr"] ?? "";
    detailList.addAll([title,place,placeAddr]);
    //print("ㄷㅌㅇ${_detailList}");
    return detailList;
  }

  @override
  void onInit() {
    super.onInit();
    returnToJson1(seq: "234964");
    print(data);
  }
}