// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapController extends GetxController {
//   List? data = [].obs;
//   String? imageUrl;
//
//   //구글맵에 사용되는 변수
//   Completer<GoogleMapController> _controller = Completer();
//   Completer<GoogleMapController> _controller2 = Completer();
//   Map<MarkerId, Marker> markers = {};
//   Map<MarkerId, Marker> markers2 = {};
//   CameraPosition? _GoogleMapCamera; //전체 지도의 마커
//   CameraPosition? _GoogleMapCamera2; //상세 페이지의 마커
//   Marker? marker;
//   Marker? marker2;
//
//   void getImage() {
//     if (markDataG == null) {
//       getImageData(campDataG!.campId.toString());
//     } else {
//       getImageData(markDataG!.campId1.toString());
//     }
//   }
//
//   void getGoogle() {
//     if (markDataG == null) {
//       _GoogleMapCamera = CameraPosition(
//         target: LatLng(double.parse(campDataG!.mapy.toString()),
//             double.parse(campDataG!.mapx.toString())),
//         zoom: 16,
//       );
//       MarkerId markerId = MarkerId(campDataG.hashCode.toString());
//       marker = Marker(
//           icon: BitmapDescriptor.defaultMarkerWithHue(10.0),
//           position: LatLng(double.parse(campDataG!.mapy.toString()),
//               double.parse(campDataG!.mapx.toString())),
//           flat: true,
//           markerId: markerId);
//       markers[markerId] = marker!;
//     }
//   }
//   Widget getGoogleMap(context) {
//     return SizedBox(
//       height: 150,
//       width: MediaQuery.of(context).size.width - 50,
//       child: GoogleMap(
//           scrollGesturesEnabled: true,
//           mapType: MapType.normal,
//           initialCameraPosition: _GoogleMapCamera!,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//           markers: Set<Marker>.of(markers.values)),
//     );
//   }
// }