import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seoul_exhibition_info/Design/ColorBox.dart';
import 'package:seoul_exhibition_info/Design/width_height.dart';
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
  Exhibition get _exhibition => widget.exhibition;

  DetailController _detailController = Get.put(DetailController());
  NormalInfoController normalInfoController = Get.put(NormalInfoController());

  List<String> _detailList = [];
  var data;

  Future<List<String>> returnToJson1({required String seq}) async {
    const String _key =
        "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
    //"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key"
    data = await normalInfoController.getJsonFromXMLUrl(
        "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=$seq&serviceKey=$_key");
    String title = data["response"]["msgBody"]["perforInfo"]["title"];
    String place = data["response"]["msgBody"]["perforInfo"]["place"];
    String placeAddr = data["response"]["msgBody"]["perforInfo"]["placeAddr"];
    _detailList.addAll([title, place, placeAddr]);
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
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future:
              _detailController.returnToJson1(seq: _exhibition.seq.toString()),
          //returnToJson1(seq: _exhibition.seq.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final exhibitionData = snapshot.data;
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Image.network(
                          snapshot.data[8].toString(),
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          fit: BoxFit.cover,
                        )),
                    Padding(
                      padding: leftWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: regularSpace),
                          Obx(
                            () => exhibitionData[0] != ""
                                ? Text(
                                    exhibitionData[0],
                                    style: TextStyle(
                                        color: ColorBox.fontColor,
                                        fontSize: 24,
                                        fontFamily: "cusFont"),
                                  )
                                : Text("데이터가 없습니다."),
                          ),
                          SizedBox(height: regularSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              // 전시 기간
                              Obx(
                                () => exhibitionData[1] != ""
                                    ? Text(
                                        "${snapshot.data[1]} ~ ${snapshot.data[2]}",
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text("데이터가 없습니다."),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(
                                () => exhibitionData[7] != ""
                                    ? Text(
                                        exhibitionData[5],
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text("데이터가 없습니다."),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(
                                () => exhibitionData[3] != ""
                                    ? Text(
                                        exhibitionData[3],
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text("데이터가 없습니다."),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Divider(
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          SizedBox(height: smallSpace),
                          Text(
                            "분류",
                            style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 24,
                                fontFamily: "cusFont"),
                          ),
                          SizedBox(height: regularSpace),
                          //분류 카테고리입니다. 해당 공연의 타입과 위치 정보를 보여줍니다.
                          //[4] => 지역 [11] => 분류
                          Row(
                            children: [
                              Icon(
                                Icons.local_florist_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(() => exhibitionData[4] != ""
                                    ? Text(
                                        exhibitionData[4],
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text(
                                        "데이터가 없습니다.",
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(
                                () => exhibitionData[11] != ""
                                    ? Text(
                                        exhibitionData[11],
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text(
                                        "데이터가 없습니다.",
                                        style: TextStyle(
                                          color: ColorBox.fontColor,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Divider(
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          SizedBox(height: smallSpace),
                          //전시관 정보 및 소개글 링크를 보여줍니다.
                          //[10] => 게시글 내용,
                          Text(
                            "전시 소개",
                            style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 24,
                                fontFamily: "cusFont"),
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(() => exhibitionData[11] != ""
                                    ? Text(
                                  exhibitionData[11],
                                  style: TextStyle(
                                    color: ColorBox.fontColor,
                                    fontSize: 18,
                                  ),
                                )
                                    : Text(
                                  "데이터가 없습니다.",
                                  style: TextStyle(
                                    color: ColorBox.fontColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                  child: SpinKitFadingFour(
                color: Colors.black,
              ));
            } else if (!snapshot.hasError) {
              return Text("데이터가 없어요");
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          },
        ));
  }

  Widget makeRowDetailText(String intro) {
    return Row(
      children: [
        Icon(
          Icons.date_range_outlined,
          size: 30,
          color: ColorBox.subFontColor,
        ),
        SizedBox(
          width: smallSpace,
        ),
        Obx(() => intro[1] != ""
              ? Text(
                  intro,
                  style: TextStyle(
                    color: ColorBox.fontColor,
                    fontSize: 18,
                  ),
                )
              : Text("데이터가 없습니다."),
        ),
      ],
    );
  }
}
