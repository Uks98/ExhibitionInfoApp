import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';

class RowOptionController extends GetxController{

  ScrollController scrollController = ScrollController();
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());
  int _rowIndex = 10; //api row query
  DateTime now = DateTime.now().subtract(Duration(days: 30));
  DateTime endNow = DateTime.now();
  String get time => DateFormat("yyyyMMdd").format(now);
  String get endTime => DateFormat("yyyyMMdd").format(endNow);
  void changeOption(int index){
    print("내 시간 : ${time}");
    if(index == 0){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "전시");
      scrollData("전시");
    }else if(index == 1){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "예술");
      scrollData("예술");
    }else if(index == 2){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "연극");
      scrollData("연극");
    }else if(index == 3){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "음악");
      scrollData("음악");
    }else if(index == 4){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "국악");
      scrollData("국악");
    }else{
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "전시");
      scrollData("");
    }
  }
  void scrollData(String keyWord){
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        _rowIndex += 10;
        //LocationClass.toastMessage(Get.context!, "더 많은 데이터를 불러왔습니다.");
        print("${_rowIndex}밑바닥");
        _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: keyWord,row: _rowIndex);
      }
    });
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeOption(0);
  }
}