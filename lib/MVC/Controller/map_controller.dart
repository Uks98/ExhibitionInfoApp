import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart' as exhibitionData;
import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int _count = 0;
  final Map<String, Marker> _markers = {};
  String get keyword => this.keyword;
  List<Exhibition> locationData = []; // Futuer list<LocationMapData>에서 반환한 리스트 받아오기
  int _locationCount = 0;
  double latitude = LocationClass.latitude;
  double longitude = LocationClass.longitude;
  //LocationClass locations = LocationClass();
  //var googleOffices1;
  GoogleMapController? googleMapController;
  Completer<GoogleMapController> _completer = Completer(); //카메라 위치를 바꾸기 위한 변수
  Future<void> animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(target: LatLng(lat, lng), zoom: 10.0);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  } //카메라 위치를 바꾸기 위한 함수

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _completer.complete(controller);
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "lib/map_marker/search.png",
    ); //구글 맵 마커 변경 변수
    final googleOffices1 = await exhibitionData.getGoogleOffices2();
    setState(() {
      _markers.clear();
      for (final office in googleOffices1.offices1!) {
        final marker = Marker(
          icon: markerbitmap,
          onTap: () {},
          markerId: MarkerId((_count += 1).toString()),
          position: LatLng(double.parse(office.gpsY.toString()),
              double.parse(office.gpsX.toString())),
        );
        _markers[(_count += 1).toString()] = marker;
      }
    }
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
    print("위도 : ${latitude}");
    print(longitude);
    _onMapCreated;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 60,
                  child: latitude != null ?GoogleMap(
                    // onCameraMove: ,
                    //circles: circles,
                    //내 위치 주변으로 원 둘레 생성
                    myLocationEnabled: false,
                    // 내 위치 활성화
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 13,
                    ),
                    markers: _markers.values.toSet(),
                  ) : Center(child: CircularProgressIndicator(),),
                ),
              ],
            )
          ],
        );
  }
}