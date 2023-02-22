import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seoul_exhibition_info/Design/ColorBox.dart';
import 'package:seoul_exhibition_info/Design/width_height.dart';
import 'package:seoul_exhibition_info/MVC/Controller/detail_controller.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  var data;

  late GoogleMapController _controller;

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  CameraPosition get _initialPosition =>
  CameraPosition(
      zoom: 9,
      target: LatLng(double.parse(_exhibition.gpsY.toString(),),double.parse(_exhibition.gpsX.toString())));

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  addMarker() async{
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "lib/map_marker/search.png",
    );
    int id = Random().nextInt(100);
    setState(() {
      markers.add(Marker(
        icon: markerbitmap,
        onTap: (){
          print(_exhibition.title);
        },
          position: LatLng(double.parse(_exhibition.gpsY.toString()),
              double.parse(_exhibition.gpsX.toString())), markerId: MarkerId(id.toString())));
    });
  }
  @override
  void initState() {
    super.initState();
    addMarker();
    print(_exhibition.seq.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: ColorBox.subFontColor,),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: _detailController.returnToJson1(seq: _exhibition.seq.toString()),
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
                          height: 600,
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
                            "전시 정보",
                            style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 24,
                                fontFamily: "cusFont"),
                          ),
                          SizedBox(height: smallSpace),
                          Container(
                            width: MediaQuery.of(context).size.width -20,
                            child: Obx(() => exhibitionData[10] != ""
                                ? Text(
                              exhibitionData[10],
                              style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 18,
                              ),
                            )
                                : Text(
                              "해당 공연의 소개가 없습니다 :(",
                              style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 18,
                              ),
                            ),
                            ),
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.link_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //url 정보
                            exhibitionData[6] != "" ? GestureDetector(
                              onTap: ()=>_detailController.goWeb(exhibitionData[6]),
                              child: Text(
                                    "공연 웹사이트로 이동하기",
                                    style: TextStyle(
                                      color: ColorBox.fontColor,
                                      fontSize: 18,
                                    ),
                                  ),
                            )
                                    : Text(
                                  "공연 웹사이트가 없습니다. :(",
                                  style: TextStyle(
                                    color: ColorBox.fontColor,
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: smallSpace),
                          Row(
                            children: [
                              Icon(
                                Icons.call_outlined,
                                size: 30,
                                color: ColorBox.subFontColor,
                              ),
                              SizedBox(
                                width: smallSpace,
                              ),
                              //가격 정보
                              Obx(() => exhibitionData[7] != ""
                                    ? GestureDetector(
                                onTap: () => _detailController.launchPhoneURL(exhibitionData[7]),
                                      child: Text(
                                  exhibitionData[7],
                                  style: TextStyle(
                                      color: ColorBox.fontColor,
                                      fontSize: 18,
                                  ),
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
                          SizedBox(height: smallSpace,),
                          Text(
                            "위치 안내",
                            style: TextStyle(
                                color: ColorBox.fontColor,
                                fontSize: 24,
                                fontFamily: "cusFont"),
                          ),
                          SizedBox(height: smallSpace,),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: GoogleMap(
                        trafficEnabled: true,
                        initialCameraPosition: _initialPosition,
                        mapType: MapType.normal,
                        onMapCreated: (controller) {
                          setState(() {
                            _controller = controller;
                          });
                        },
                        markers: Set.from(markers)
                      ),
                    ),
                    SizedBox(height: largeSpace,),
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
