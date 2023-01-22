import 'dart:convert';
import 'dart:io';

import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_mark.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Exhibition {
  String? seq;
  String? title;
  String? startDay;
  String? endDay;
  String? place;
  String? realName; //종목
  String? area; //지역
  String? thumb;
  String? gpsX;
  String? gpsY;

  Exhibition(
      {required this.seq,
      required this.title,
      required this.startDay,
      required this.endDay,
      required this.place,
      required this.realName,
      required this.area,
      required this.thumb,
      required this.gpsX,
      required this.gpsY});

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
        seq: json["seq"].toString(),
        title: json["title"].toString(),
        startDay: json["startDate"].toString(),
        endDay: json["endDate"].toString(),
        place: json["place"].toString(),
        realName: json["realName"].toString(),
        area: json["area"].toString(),
        thumb: json["thumbnail"].toString(),
        gpsX: json["gpsX"].toString(),
        gpsY: json["gpsY"].toString());
  }
}

Future<LocationMarkerInfo> getGoogleOffices2() async {
  NormalInfoController normalInfoController = NormalInfoController();
  String _key = "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
// 위도 경도가 서로 다름..

  var googleLocationsURL = NormalInfoController.data;
  print("리스폰스 : 구글 어피스 : ${googleLocationsURL}");
  final response = await http.get(Uri.parse(googleLocationsURL));
  print("리스폰스 : 구글 어피스 : ${response}");
  if (response.statusCode == 200) {
    print("body : ${response.body}");
//Map<String,dynamic>형식으로 저장
    return LocationMarkerInfo.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes))); //한글깨짐수정
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
