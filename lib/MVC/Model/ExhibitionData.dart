
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
      {required this.seq, required this.title, required this.startDay, required this.endDay, required this.place,
        required this.realName, required this.area, required this.thumb, required this.gpsX, required this.gpsY});

  factory Exhibition.fromJson(Map<String, dynamic>json){
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