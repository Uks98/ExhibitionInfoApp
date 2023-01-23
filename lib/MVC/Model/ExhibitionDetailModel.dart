import 'dart:convert';
import 'dart:io';

import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_mark.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:xml2json/xml2json.dart';

class ExhibitionDetail {
  String? startDate;
  String? endDate;
  String? place;
  String? realName; //종목
  String? price;
  String? url;
  String? phone;
  String? imgUrl;
  String? gpsX;
  String? gpsY;
  String? placeUrl;
  String? placeAddr;

  ExhibitionDetail(
      {
        this.startDate,
        this.endDate,
        this.place,
        this.realName,
        this.price,
        this.url,
        this.phone,
        this.imgUrl,
        this.gpsX,
        this.gpsY,
        this.placeUrl,
        this.placeAddr,
        });

  factory ExhibitionDetail.fromJson(Map<String, dynamic> json) {
    return ExhibitionDetail(
        startDate: json["startDate"].toString(),
        endDate: json["endDate"].toString(),
        place: json["place"].toString(),
        realName: json["realName"].toString(),
        price: json["price"].toString(),
        url: json["url"].toString(),
        phone: json["phone"].toString(),
        imgUrl: json["imgUrl"].toString(),
        gpsX: json["gpsX"].toString(),
        gpsY: json["gpsY"].toString(),
        placeUrl: json["placeUrl"].toString(),
        placeAddr: json["placeAddr"].toString(),

    );
  }
}

