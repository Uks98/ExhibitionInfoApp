import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/Design/ColorBox.dart';
import 'package:seoul_exhibition_info/Design/font.dart';
import 'package:seoul_exhibition_info/Design/width_height.dart';
import 'package:seoul_exhibition_info/MVC/Controller/calenderController.dart';
import 'package:seoul_exhibition_info/MVC/Controller/map_controller.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';
import 'package:seoul_exhibition_info/MVC/Controller/row_option_widget.dart';
import 'package:seoul_exhibition_info/MVC/Model/location_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class MainInfoPage extends StatelessWidget {
  MainInfoPage({Key? key}) : super(key: key);
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());
  RowOptionController _rowOptionController = Get.put(RowOptionController());
  CalenderController _calendarController = Get.put(CalenderController());
  //LocationController _locationController = Get.put(LocationController());
  List<String> optionList = ["전시", "미술", "연극", "음악", "국악"];
  int _colorIndex = 0;




@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        LocationPage(),
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 30),
          child: NeumorphicButton(
            onPressed: () {
            _calendarController.show(context);
            },
            style: NeumorphicStyle(
              color: Colors.grey[200],
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey[700],
            ),
          ),
        ),
        SlidingUpPanel(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          minHeight: 300,
          maxHeight: MediaQuery
              .of(context)
              .size
              .height - 50,
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
  return GetX<NormalInfoController>(builder: (controller) {
    return ListView.separated(
      controller: sc,
      itemCount: _normalInfoController.mainExhibitionList.length,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return rowOptionWidget(context);
        }
        final exIndex = _normalInfoController.mainExhibitionList[i];
        return Column(
          children: [

            Container(
              padding: const EdgeInsets.all(12.0),
              child: MainExhibitionView(
                context,
                imageUrl: exIndex.thumb.toString(),
                name: exIndex.title.toString(),
                location: exIndex.place.toString(),
                startDay: exIndex.startDay.toString(),
                endDay: exIndex.endDay.toString(),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 10,
          endIndent: 10,
          thickness: 1,
        );
      },
    );
  });
}

//리스트 뷰로 그려지는 아이템
Widget MainExhibitionView(BuildContext context,
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
        SizedBox(
          width: regularSpace,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240,
                child: Text(
                  name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: regularSpace,
              ),
              Text(
                location,
                style: TextStyle(color: ColorBox.subFontColor, fontSize: 16),
              ),
              SizedBox(
                height: smallSpace,
              ),
              Text(
                "${startDatF} ~ ${endDatF}",
                style: TextStyle(color: ColorBox.subFontColor, fontSize: 14),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
//바텀시트에 옵션 버튼을 나타내는 위젯
Widget rowOptionWidget(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(width: smallSpace,),
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 10,
        height: 35,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _colorIndex = index;
                _rowOptionController.changeOption(index);
              },
              child: Container(
                width: 80,
                decoration: ShapeDecoration(
                  color: index == _colorIndex ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                child: Center(child: index == _colorIndex
                    ? Text(
                    optionList[index], style: TextStyle(color: Colors.white))
                    : Text(optionList[index],)),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: smallSpace,
            );
          },
          itemCount: optionList.length,
        ),
      )
    ],
  );
}}
