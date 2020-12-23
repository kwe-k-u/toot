


import 'dart:convert';

import 'package:twitter_api/utlils/twitter_api.dart';


List<String> _months = ["Jan", "Feb",	"Mar", 	"Apr",	"May", 	"June", 	"July",
  "Aug",	"Sept",	"Oct", 	"Nov",	"Dec"];


///Obtains a date format as a string and converts it into a dart DateTime object
dynamic convertTwitterDate(String d){
  DateTime newDate;

  List<String> date = d.split(" ");

  newDate = new DateTime(
    int.parse(date.elementAt(5)), //year
    _months.indexOf(date.elementAt(1)) + 1, //month
    int.parse(date.elementAt(2)),//date
    int.parse(date.elementAt(3).split(":").elementAt(0)),// hour
    int.parse(date.elementAt(3).split(":").elementAt(1)),// minute
    int.parse(date.elementAt(3).split(":").elementAt(2)),// second
  );

  return newDate;
}


///Converts numbers to twitter styled statistics.
///Accepts only int or numbers as a string
///Eg:
///   2000 becomes 2k
String statText(dynamic data){
  String text = "";
  if (data.runtimeType == Null)
    return null.toString();
  if (data.runtimeType == String)
    data = int.parse(data);

  //don't change format if the number is less than 2k
  if (data <2000)
    text = data.toString();

  //Change to xM if number is a multiple of a million
  else if (data > 2000){
    text = "${data~/1000}k";
  }
  else if (data > 1000000){
    text = "${data~/1000000}M";
  } else{
    text = data.toString();
  }

  return text.toString();
}





///Returns a json object for the twitter user that matches the [id]
Future<Map<String,dynamic>> findUser(String id) async{
  var au = new twitterApi(
    consumerKey: "NxaAqeLwbd3bI0of36MF5sjs3",
    consumerSecret: "1Pp0BWpGeHXwLNCLGSC4SkNPkyZKCV2rWjv55LjD2PZ81WqAxN",
    token: "721809764-mzwYMd8R89NajMboUuZ6YZkBuCkDlFcP8YzDg3Qv",
    tokenSecret: "M9QxNtnp6wuaLN27oSQtQ0coR6vv8e8ETRKuTygMGPXt6",
  );

  Future twitterRequest = au.getTwitterRequest(
    // Http Method
    "GET",
    // Endpoint you are trying to reach
    "/users/lookup.json",
    // The options for the request
    options: {
      "user_id": id,
    },
  );

  // Wait for the future to finish
  var res = await twitterRequest;

  // Print off the response

  // Convert the string response into something more useable
  dynamic t = json.decode(res.body);

  // for (Map<dynamic, dynamic> map in t){
  //   // print("asdf t is $map");
  // }
  return Map<String,dynamic>.of(t[0]);
}



///Returns a string that represents the difference between current time and entered time
String timeCreated(DateTime date){
  String period = "";
  DateTime now = new DateTime.now();
  DateTime lastWeek = new DateTime.now().subtract(Duration(days: 7));


  try {
    //If the entered date is today
    if (now.month == date.month && now.day == date.day &&
        now.year == date.year) {
      //Finding how many hours ago it was
      if (now.hour == date.hour)
        period = "${now.minute - date.minute} min";
      else
        period = "${date.hour - now.hour}h";

    } else if (date.isAfter(now.subtract(Duration(days:  7)))){
      //If the entered date was within a week ago
      for (int count = 1; count <7; count++) {
        period = count.toString();
        if (now.subtract(Duration(days: count)).day == date.day)
          break;
      }
      period  += "d";
    }
    else if (now.year == date.year) {
      //If the entered date was this year, return day and month
      period = "${date.day} ${_months[date.month-1]}";

    } else {
      period = "${date.day} ${_months[date.month-1]} ${date.year}";
    }
  }
  catch(e){
    print("error $e");
    return "";
  }


  return period;
}