import 'dart:convert';
import 'dart:io';

import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_mark.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:xml2json/xml2json.dart';

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
  final Xml2Json xml2Json = Xml2Json();
  var googleLocationsURL = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period?from=20221118&to=20230117&cPage=1&rows=31&place=서울&gpsxfrom=&gpsyfrom=&gpsxto=&gpsyto=&keyword=&sortStdr=1&serviceKey=iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";
  print(googleLocationsURL);

  final response = await http.get(Uri.parse(googleLocationsURL));
  xml2Json.parse(utf8.decode(response.bodyBytes));
  var jsonString = xml2Json.toParker();
  print("리스폰스 : 구글 어피스 : ${response}");
  if (response.statusCode == 200) {
    print("jsonString : ${jsonString}");
    return LocationMarkerInfo.fromJson(
        jsonDecode(jsonString)); //한글깨짐수정
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
