import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';

class RowOptionController extends GetxController{
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());
  void changeOption(int index){
    DateTime now = DateTime.now().subtract(Duration(days: 30));
    DateTime endNow = DateTime.now();
    String time = DateFormat("yyyyMMdd").format(now);
    String endTime = DateFormat("yyyyMMdd").format(endNow);
    print("내 시간 : ${time}");
    if(index == 0){
      print(time);
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "전시");
    }else if(index == 1){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "예술");
    }else if(index == 2){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "연극");
    }else if(index == 3){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "음악");
    }else if(index == 4){
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "국악");
    }else{
      _normalInfoController.getExhibitionData(startDay: time, endDay: endTime, place: "", keyword: "전시");
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeOption(0);
  }
}