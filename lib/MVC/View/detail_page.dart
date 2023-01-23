import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seoul_exhibition_info/MVC/Controller/detail_controller.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart';


class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.exhibition}) : super(key: key);
  final Exhibition exhibition;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Exhibition get _exhibition=> widget.exhibition;

  DetailController _detailController = Get.put(DetailController());
  NormalInfoController normalInfoController = Get.put(NormalInfoController());

  List<String> _detailList = [];
  Future<List<String>> returnToJson({required String seq,}) async {
    const String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
    //"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key"
    final data = await normalInfoController.getJsonFromXMLUrl(
        "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key");
    String title = data["response"]["msgBody"]["perforInfo"]["title"];
    String place = data["response"]["msgBody"]["perforInfo"]["place"];
    _detailList.addAll([title,place]);
    print("ㄷㅌㅇ${_detailList}");
    return _detailList;
  }

  void getDetailList()async{

    _detailList = await _detailController.returnToJson(seq: _exhibition.seq.toString());
    print("디테일 리스트 ${_detailList[0]}");
    print("디테일 리스트1 ${_detailController.detailList.length}");
  }

  @override
  void initState() {
    super.initState();
    getDetailList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _detailList.isEmpty ? Center(child: CircularProgressIndicator(),):GetX<DetailController>(
          builder: (controller) {
            return Text(controller.detailList[0].toString());
          }
        ),
    );
  }
}
