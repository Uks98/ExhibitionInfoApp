// import 'dart:convert';
// import 'dart:io';
//
// import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
// import 'package:seoul_exhibition_info/MVC/Model/location_mark.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
//
// import 'package:xml2json/xml2json.dart';
//
// class ExhibitionDetail {
//   String? title;
//   String? startDate;
//   String? endDate;
//   String? place;
//   String? realName; //종목
//   String? price;
//   String? url;
//   String? phone;
//   String? imgUrl;
//   String? gpsX;
//   String? gpsY;
//   String? placeUrl;
//   String? placeAddr;
//
//   ExhibitionDetail(
//       {
//         this.title,
//         this.startDate,
//         this.endDate,
//         this.place,
//         this.realName,
//         this.price,
//         this.url,
//         this.phone,
//         this.imgUrl,
//         this.gpsX,
//         this.gpsY,
//         this.placeUrl,
//         this.placeAddr,
//         });
//
//   factory ExhibitionDetail.fromJson(Map<String, dynamic> json) {
//     return ExhibitionDetail(
//         title: json["title"].toString(),
//         startDate: json["startDate"].toString(),
//         endDate: json["endDate"].toString(),
//         place: json["place"].toString(),
//         realName: json["realName"].toString(),
//         price: json["price"].toString(),
//         url: json["url"].toString(),
//         phone: json["phone"].toString(),
//         imgUrl: json["imgUrl"].toString(),
//         gpsX: json["gpsX"].toString(),
//         gpsY: json["gpsY"].toString(),
//         placeUrl: json["placeUrl"].toString(),
//         placeAddr: json["placeAddr"].toString(),
//
//     );
//   }
// }
//
// To parse this JSON data, do
//
//     final exhibitionDetail = exhibitionDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ExhibitionDetail exhibitionDetailFromJson(String str) => ExhibitionDetail.fromJson(json.decode(str));

String exhibitionDetailToJson(ExhibitionDetail data) => json.encode(data.toJson());

class ExhibitionDetail {
  ExhibitionDetail({
    required this.response,
  });

  final Response response;

  factory ExhibitionDetail.fromJson(Map<String, dynamic> json) => ExhibitionDetail(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  Response({
    required this.comMsgHeader,
    required this.msgBody,
  });

  final ComMsgHeader comMsgHeader;
  final MsgBody msgBody;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    comMsgHeader: ComMsgHeader.fromJson(json["comMsgHeader"]),
    msgBody: MsgBody.fromJson(json["msgBody"]),
  );

  Map<String, dynamic> toJson() => {
    "comMsgHeader": comMsgHeader.toJson(),
    "msgBody": msgBody.toJson(),
  };
}

class ComMsgHeader {
  ComMsgHeader({
    required this.requestMsgId,
    required this.responseTime,
    required this.responseMsgId,
    required this.successYn,
    required this.returnCode,
    required this.errMsg,
  });

  final String requestMsgId;
  final DateTime responseTime;
  final String responseMsgId;
  final String successYn;
  final int returnCode;
  final String errMsg;

  factory ComMsgHeader.fromJson(Map<String, dynamic> json) => ComMsgHeader(
    requestMsgId: json["RequestMsgID"],
    responseTime: DateTime.parse(json["ResponseTime"]),
    responseMsgId: json["ResponseMsgID"],
    successYn: json["SuccessYN"],
    returnCode: json["ReturnCode"],
    errMsg: json["ErrMsg"],
  );

  Map<String, dynamic> toJson() => {
    "RequestMsgID": requestMsgId,
    "ResponseTime": responseTime.toIso8601String(),
    "ResponseMsgID": responseMsgId,
    "SuccessYN": successYn,
    "ReturnCode": returnCode,
    "ErrMsg": errMsg,
  };
}

class MsgBody {
  MsgBody({
    required this.seq,
    required this.perforInfo,
  });

  final int seq;
  final PerforInfo perforInfo;

  factory MsgBody.fromJson(Map<String, dynamic> json) => MsgBody(
    seq: json["seq"],
    perforInfo: PerforInfo.fromJson(json["perforInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "seq": seq,
    "perforInfo": perforInfo.toJson(),
  };
}

class PerforInfo {
  PerforInfo({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.realmName,
    required this.area,
    required this.subTitle,
    required this.price,
    required this.url,
    required this.phone,
    required this.imgUrl,
    required this.gpsX,
    required this.gpsY,
    required this.placeUrl,
    required this.placeAddr,
  });

  final String title;
  final int startDate;
  final int endDate;
  final String place;
  final String realmName;
  final String area;
  final String subTitle;
  final String price;
  final String url;
  final String phone;
  final String imgUrl;
  final double gpsX;
  final double gpsY;
  final String placeUrl;
  final String placeAddr;

  factory PerforInfo.fromJson(Map<String, dynamic> json) => PerforInfo(
    title: json["title"].toString(),
    startDate: int.parse(json["startDate"] ?? 0.toString()),
    endDate: int.parse(json["endDate"] ?? 0.toString()),
    place: json["place"].toString(),
    realmName: json["realmName"].toString(),
    area: json["area"].toString(),
    subTitle: json["subTitle"].toString(),
    price: json["price"].toString(),
    url: json["url"].toString(),
    phone: json["phone"].toString(),
    imgUrl: json["imgUrl"].toString(),
    gpsX: double.parse(json["gpsX"] ?? 1.0.toString()),
    gpsY: double.parse(json["gpsY"] ?? 1.0.toString()),
    placeUrl: json["placeUrl"].toString(),
    placeAddr: json["placeAddr"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "startDate": startDate,
    "endDate": endDate,
    "place": place,
    "realmName": realmName,
    "area": area,
    "subTitle": subTitle,
    "price": price,
    "url": url,
    "phone": phone,
    "imgUrl": imgUrl,
    "gpsX": gpsX,
    "gpsY": gpsY,
    "placeUrl": placeUrl,
    "placeAddr": placeAddr,
  };
}
