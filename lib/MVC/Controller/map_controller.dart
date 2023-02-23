import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart'
    as exhibitionData;
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';

import '../../Design/ColorBox.dart';
import '../../Design/width_height.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int _count = 0;
  final Map<String, Marker> _markers = {}; //메인 화면 마커
  List<String> locationList = ["서울", "부산", "전북", "울산"]; // 지역 리스트
  String _locationText = "전북"; // 서울로 초기화 된 맵 마커 변경 변슈
  String get keyword => this.keyword;

  double latitude = LocationClass.latitude;
  double longitude = LocationClass.longitude;

  GoogleMapController? googleMapController;
  int _locationIndex = 0; // 지역 위치 변경 인덱스
  Completer<GoogleMapController> _completer = Completer(); //카메라 위치를 바꾸기 위한 변수
  Future<void> animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(target: LatLng(lat, lng), zoom: 10.0);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  } //카메라 위치를 바꾸기 위한 함수

  Future<void> onMapCreated(GoogleMapController? controller) async {
    _completer.complete(controller);
    //구글 맵 마커 변경 변수
    //마커만 따로 작업하기 위해 마커 함수 생성
    locationMarker("서울");
  }

  void locationMarker(String text) async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "lib/map_marker/search.png",
    );
    _locationText = text;
    final googleOffices1 =
        await exhibitionData.getGoogleOffices2(keyword: _locationText);
    setState(() {
      _markers.clear();
      for (final office in googleOffices1.offices1!) {
        final marker = Marker(
          icon: markerbitmap,
          onTap: () => getMarkerInfo(office.title.toString(),
              office.place.toString(), office.thumb.toString(),office.startDay.toString(),office.endDay.toString()),
          markerId: MarkerId((_count.toString().hashCode).toString()),
          position: LatLng(double.parse(office.gpsY.toString()),
              double.parse(office.gpsX.toString())),
        );
        _markers[(_count += 1).toString()] = marker;
      }
    });
  }

  // 맵 위치 위젯[서울..부산]
  Widget findLocations(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: smallSpace,
        ),
        Container(
          width: 300,
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: NeumorphicButton(
                    onPressed: () {
                      _locationIndex = index;
                      if (_locationIndex == 0) {
                        //서울시 위도 경도
                        latitude = 37.514575;
                        longitude = 127.0495556;
                        animateTo(latitude, longitude); //카메라 이동 변수
                        setState(() {
                          locationMarker("서울");//전시회 api query 요청 변수
                        });
                        print(_locationIndex);
                      } else if (_locationIndex == 1) {
                        latitude = 35.13340833;
                        longitude = 129.0865;
                        animateTo(latitude, longitude); //카메라 이동 변수
                        setState(() {
                          locationMarker("부산");//전시회 api query 요청 변수
                        });
                      }else if(_locationIndex == 2){
                        latitude = 35.80918889;
                        longitude = 127.1219194;
                        animateTo(latitude, longitude); //카메라 이동 변수
                        setState(() {
                          locationMarker("전북"); //전시회 api query 요청 변수
                        });
                      } else {
                        latitude = 35.54404265;
                        longitude = 129.3301754;
                        animateTo(latitude, longitude); //카메라 이동 변수
                        setState(() {
                          locationMarker("울산"); //전시회 api query 요청 변수
                        });
                      }
                    },
                    style: NeumorphicStyle(
                      depth: 8,
                      color: Colors.grey[200],
                      shape: NeumorphicShape.convex,
                      lightSource: LightSource.top,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      locationList[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: smallSpace,
              );
            },
            itemCount: locationList.length,
          ),
        )
      ],
    );
  }

  void getMarkerInfo(String title, String content,String thumb,String startDay,String endDay) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.43, //바텀시트 높이조절
        minChildSize: 0.3,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Expanded(
                child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(width: regularSpace,),
                    Container(
                      width: 140,
                      height: 200,
                      child: Image.network(thumb,fit: BoxFit.contain,),
                    ),
                    SizedBox(width: smallSpace + 10,),
                    Container(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 240,
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: regularSpace,
                          ),
                          Text(
                            content,
                            style: TextStyle(color: ColorBox.subFontColor, fontSize: 16),
                          ),
                          SizedBox(
                            height: smallSpace,
                          ),
                          Text(
                            "${startDay} ~ ${endDay}",
                            style: TextStyle(color: ColorBox.subFontColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  // Set<Circle> circles = Set.from([
  //   Circle(
  //     fillColor: Colors.orange.shade100.withOpacity(0.5),
  //     strokeColor: Colors.blue.shade100.withOpacity(0.1),
  //     circleId: CircleId(DateTime.now().microsecondsSinceEpoch.toString()),
  //     center: LatLng(LocationClass.latitude, LocationClass.longitude),
  //     radius: 20000,
  //   )
  // ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onMapCreated;
    print("위도 : ${latitude}");
    print(longitude);
  }

  @override
  Widget build(BuildContext context) {
    return latitude != 0.0
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Expanded(child: googleMap()),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0, top: 15),
                  child: Row(
                    children: [findLocations(context)],
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget googleMap() {
    return GoogleMap(
      // onCameraMove: ,
      //circles: circles,
      //내 위치 주변으로 원 둘레 생성
      myLocationEnabled: false,
      // 내 위치 활성화
      mapType: MapType.normal,
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          latitude != "" ? latitude : 37.566535,
          longitude != "" ? longitude : 126.9779683,
        ),
        zoom: 13,
      ),
      markers: _markers.values.toSet(),
    );
  }
}
