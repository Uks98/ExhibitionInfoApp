import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/Design/ColorBox.dart';
import 'package:seoul_exhibition_info/Design/font.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainInfoPage extends StatelessWidget {
  MainInfoPage({Key? key}) : super(key: key);
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 600,
            color: Colors.black,
          ),
          ElevatedButton(onPressed: (){
            _normalInfoController.getExhibitionData(startDay: "20221118", endDay: "20230117", place: "부산", keyword: "");
          }, child: Text("s")),
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            minHeight: 300,
            maxHeight: MediaQuery.of(context).size.height - 50,
            panelBuilder: (ScrollController sc) {
              return _scrollingList(sc);
            },
          ),
        ],
      ),
    );
  }

  //패널 스크롤 관련 위젯 함수
  Widget _scrollingList(ScrollController sc) {
    return GetX<NormalInfoController>(
      builder: (controller) {
        return ListView.separated(
          controller: sc,
          itemCount: _normalInfoController.mainExhibitionList.length,
          itemBuilder: (BuildContext context, int i) {
            final exIndex = _normalInfoController.mainExhibitionList[i];
            return Container(
              padding: const EdgeInsets.all(12.0),
              child: MainExhibitionView(
                imageUrl: exIndex.thumb.toString(),
                name: exIndex.title.toString(),
                location: exIndex.place.toString(),
                startDay: exIndex.startDay.toString(),
                endDay: exIndex.endDay.toString(),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return Divider(indent: 10,endIndent: 10,thickness: 1,);
        },
        );
      }
    );
  }

  //리스트 뷰로 그려지는 아이템
  Widget MainExhibitionView(
      {required String imageUrl,
      required String name,
      required String location,
      required String startDay,
      required String endDay}) {
    final convertSt = DateTime.parse(startDay);
    final convertEd = DateTime.parse(endDay);
    final startDatF = DateFormat("yyyy년 MM월 dd일").format(convertSt);
    final endDatF = DateFormat("yyyy년 MM월 dd일").format(convertEd);
    return Container(
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 100,
            height: 130,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240,
                child: Text(
                  name,
                  style: TextStyle(
                      color: ColorBox.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                location,
                style: TextStyle(color: ColorBox.subFontColor, fontSize: 16),
              ),
              Text(
                "${startDatF} ~ ${endDatF}",
                style: TextStyle(color: ColorBox.subFontColor, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
