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
  var data;
  Future<List<String>> returnToJson1({required String seq}) async {
    const String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
    //"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key"
     data = await normalInfoController.getJsonFromXMLUrl(
        "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key");
    String title = data["response"]["msgBody"]["perforInfo"]["title"];
    String place = data["response"]["msgBody"]["perforInfo"]["place"];
    String placeAddr = data["response"]["msgBody"]["perforInfo"]["placeAddr"];
    _detailList.addAll([title,place,placeAddr]);
    //print("ㄷㅌㅇ${_detailList}");
    return _detailList;
  }


  @override
  void initState() {
    super.initState();
    print(_exhibition.seq.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: 300,
          height: 500,
          child: FutureBuilder(
              future: _detailController.returnToJson1(seq: _exhibition.seq.toString()),
              //returnToJson1(seq: _exhibition.seq.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Obx(() => snapshot.data[0] != "" ? Text(snapshot.data[0]) :Text("데이터가 없습니다.") ,),
                      Obx(() => snapshot.data[1] != "" ? Text(snapshot.data[1]) :Text("데이터가 없습니다.") ,),
                      Obx(() => snapshot.data[2] != "" ? Text(snapshot.data[2]) :Text("데이터가 없습니다.") ,),
                    ],
                  );
                }else if(!snapshot.hasData){
                  return  Center(child: CircularProgressIndicator(color: Colors.black,));
                }else if(!snapshot.hasError){
                  return Text("데이터가 없어요");
                }
                return Center(child: CircularProgressIndicator(color: Colors.black,));
              },
              ),
        )
    );
  }
}
