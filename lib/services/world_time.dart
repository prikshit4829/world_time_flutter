import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String? time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api end point
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var Url = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(
          Url); //this function (from http) is used to get data from a desired location
      Map data = jsonDecode(response.body); //
      // print(data);
      //print(data['title']);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      // time = now.toString();
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not get data';
      print('caught error: $e');
    }
  }
}
