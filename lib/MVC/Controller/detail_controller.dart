
import 'package:get/get.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionDetailModel.dart';

class DetailController extends GetxController {
  var detailList = <String>[].obs;
  NormalInfoController normalInfoController = Get.put(NormalInfoController());

  static const String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";

  Future<RxList<String>> returnToJson({required String seq,}) async {
    //"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key"
    final data = await normalInfoController.getJsonFromXMLUrl(
        "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key");
    String title = data["response"]["msgBody"]["perforInfo"]["title"];
    String place = data["response"]["msgBody"]["perforInfo"]["place"];
    detailList.addAll([title,place]);
    print("ㄷㅌㅇ${detailList}");
    return detailList;
  }

  // void getsdata({required String seq})async{
  //   var ex = await returnToJson(seq: seq);
  //   detailList.value = ex;
  // }


  @override
  void onInit() {
    super.onInit();
    returnToJson(seq: "236481");
    //getsdata(seq: "236481");
    print("디테일 리스트 ${detailList}");
  }
}