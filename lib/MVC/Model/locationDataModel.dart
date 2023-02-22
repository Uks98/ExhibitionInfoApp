// To parse this JSON data, do
//
//     final locationExData = locationExDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LocationExData locationExDataFromJson(String str) => LocationExData.fromJson(json.decode(str));

String locationExDataToJson(LocationExData data) => json.encode(data.toJson());

class LocationExData {
  LocationExData({
    required this.response,
  });

  final Response response;

  factory LocationExData.fromJson(Map<String, dynamic> json) => LocationExData(
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
    required this.totalCount,
    required this.cPage,
    required this.rows,
    required this.sido,
    required this.perforList,
  });

  final int totalCount;
  final int cPage;
  final int rows;
  final Sido sido;
  final List<LocationDetail> perforList;

  factory MsgBody.fromJson(Map<String, dynamic> json) => MsgBody(
    totalCount: json["totalCount"],
    cPage: json["cPage"],
    rows: json["rows"],
    sido: sidoValues.map[json["sido"]]!,
    perforList: List<LocationDetail>.from(json["perforList"].map((x) => LocationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "cPage": cPage,
    "rows": rows,
    "sido": sidoValues.reverse[sido],
    "perforList": List<dynamic>.from(perforList.map((x) => x.toJson())),
  };
}

class LocationDetail{
  LocationDetail({
    required this.seq,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.realmName,
    required this.area,
    required this.thumbnail,
    required this.gpsX,
    required this.gpsY,
  });

  final int seq;
  final String title;
  final int startDate;
  final int endDate;
  final String place;
  final RealmName realmName;
  final Sido area;
  final String thumbnail;
  final dynamic gpsX;
  final dynamic gpsY;

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
    seq: json["seq"],
    title: json["title"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    place: json["place"],
    realmName: realmNameValues.map[json["realmName"]]!,
    area: sidoValues.map[json["area"]]!,
    thumbnail: json["thumbnail"],
    gpsX: json["gpsX"],
    gpsY: json["gpsY"],
  );

  Map<String, dynamic> toJson() => {
    "seq": seq,
    "title": title,
    "startDate": startDate,
    "endDate": endDate,
    "place": place,
    "realmName": realmNameValues.reverse[realmName],
    "area": sidoValues.reverse[area],
    "thumbnail": thumbnail,
    "gpsX": gpsX,
    "gpsY": gpsY,
  };
}

enum Sido { EMPTY }

final sidoValues = EnumValues({
  "부산": Sido.EMPTY
});

enum RealmName { EMPTY, REALM_NAME, PURPLE, FLUFFY }

final realmNameValues = EnumValues({
  "미술": RealmName.EMPTY,
  "기타": RealmName.FLUFFY,
  "음악": RealmName.PURPLE,
  "연극": RealmName.REALM_NAME
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
