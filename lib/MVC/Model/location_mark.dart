import 'package:seoul_exhibition_info/MVC/Model/ExhibitionData.dart';

class LocationMarkerInfo {
  List<Exhibition>? offices1;

  LocationMarkerInfo({required this.offices1});

  LocationMarkerInfo.fromJson(Map<String, dynamic> json) {
    offices1 = <Exhibition>[];
    //해당 키 값에 접근하기 위해 작성
    if (json["response"]["msgBody"]["perforList"] != null) {
      json["response"]["msgBody"]["perforList"].forEach((v) {
        offices1!.add(Exhibition.fromJson(v));
      });
    }
  }
}