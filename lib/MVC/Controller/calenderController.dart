
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seoul_exhibition_info/MVC/Controller/normalInfoController.dart';

class CalenderController extends GetxController{
  NormalInfoController _normalInfoController = Get.put(NormalInfoController());
  DateTimeRange? _selectedDateRange;
  void show(context) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',

    );
    if (result != null) {
      // Rebuild the UI
      _selectedDateRange = result;
      DateTime start = DateTime.parse(_selectedDateRange!.start.toString());
      DateTime end = DateTime.parse(_selectedDateRange!.end.toString());
      _normalInfoController.getExhibitionData(startDay: DateFormat("yyyyMMdd").format(start), endDay: DateFormat("yyyyMMdd").format(end), place: "", keyword: "");
      print("hello print ${_selectedDateRange?.start.toString()} ${_selectedDateRange?.end.toString()}");
      print(result.start.toString());
      return null;
    }
  }

}