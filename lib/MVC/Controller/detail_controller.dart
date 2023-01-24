
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
    String title = data["response"]["msgBody"]["perforInfo"]["title"] ?? ""; //제목0
    String startDate = data["response"]["msgBody"]["perforInfo"]["startDate"] ?? ""; //시작날짜1
    String endDate = data["response"]["msgBody"]["perforInfo"]["endDate"] ?? ""; //마지막날짜2
    String place = data["response"]["msgBody"]["perforInfo"]["place"]?? ""; //위치3
    String area = data["response"]["msgBody"]["perforInfo"]["area"]?? ""; //지역4
    String price = data["response"]["msgBody"]["perforInfo"]["price"] ?? "";//가격5
    String url = data["response"]["msgBody"]["perforInfo"]["url"] ?? "";//url6
    String phone = data["response"]["msgBody"]["perforInfo"]["phone"] ?? "";//전화번호7
    String imaUrl = data["response"]["msgBody"]["perforInfo"]["imgUrl"] ?? ""; //이미지 주소8
    String placeAddr = data["response"]["msgBody"]["perforInfo"]["placeAddr"] ?? ""; //주소9
    String content = data["response"]["msgBody"]["perforInfo"]["contents1"] ?? ""; //내용10
    String type = data["response"]["msgBody"]["perforInfo"]["realmName"] ?? ""; //분류11
    detailList.addAll([title,startDate,endDate,place,area,price,url,phone,imaUrl,placeAddr,content,type]);
    return detailList;
  }

  @override
  void onInit() {
    super.onInit();
    returnToJson1(seq: "");
    print(data);
  }
}