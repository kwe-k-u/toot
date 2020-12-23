


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



//todo list of endpoints
/*
    urate a collection of Tweets
        GET collections/entries
        GET collections/list
        GET collections/show
        POST collections/create
        POST collections/destroy
        POST collections/entries/add
        POST collections/entries/curate
        POST collections/entries/move
        POST collections/entries/remove
        POST collections/update
    Filter realtime Tweets
        POST statuses/filter
    Get Tweet timelines
        GET statuses/home_timeline
        GET statuses/mentions_timeline
        GET statuses/user_timeline
    Post, retrieve, and engage with Tweets
        GET favorites/list
        GET statuses/lookup
        GET statuses/oembed
        GET statuses/retweeters/ids
        GET statuses/retweets/:id
        GET statuses/retweets_of_me
        GET statuses/show/:id
        POST favorites/create
        POST favorites/destroy
        POST statuses/destroy/:id
        POST statuses/retweet/:id
        POST statuses/unretweet/:id
        POST statuses/update
        POST statuses/update_with_media (deprecated)
    Sample realtime Tweets
        GET statuses/sample
    Search Tweets
        GET search/tweets

Accounts and users

    Create and manage lists
        GET lists/list
        GET lists/members
        GET lists/members/show
        GET lists/memberships
        GET lists/ownerships
        GET lists/show
        GET lists/statuses
        GET lists/subscribers
        GET lists/subscribers/show
        GET lists/subscriptions
        POST lists/create
        POST lists/destroy
        POST lists/members/create
        POST lists/members/create_all
        POST lists/members/destroy
        POST lists/members/destroy_all
        POST lists/subscribers/create
        POST lists/subscribers/destroy
        POST lists/update
    Follow, search, and get users
        GET followers/ids
        GET followers/list
        GET friends/ids
        GET friendships/incoming
        GET friendships/lookup
        GET friendships/no_retweets/ids
        GET friendships/outgoing
        GET friendships/show
        GET users/search
        GET users/show
        POST friendships/create
        POST friendships/destroy
        POST friendships/update
    Manage account settings and profile
        GET account/settings
        GET account/verify_credentials
        GET saved_searches/list
        GET saved_searches/show/:id
        GET users/profile_banner
        POST account/remove_profile_banner
        POST account/settings
        POST account/update_profile
        POST account/update_profile_banner
        POST account/update_profile_image
        POST saved_searches/create
        POST saved_searches/destroy/:id
    Mute, block, and report users
        GET blocks/ids
        GET blocks/list
        GET mutes/users/ids
        GET mutes/users/list
        POST blocks/create
        POST blocks/destroy
        POST mutes/users/create
        POST mutes/users/destroy
        POST users/report_spam

 */