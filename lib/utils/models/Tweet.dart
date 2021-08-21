

import 'package:twitter_api/Objects/TwitterUserTemp.dart';
import 'package:twitter_api/utils/resources.dart';

class Tweet{

  late int id; ///The ID of the tweet
  late TwitterUserTemp twitterUser;  ///The account from which the tweet was made
  String? text; ///The string content of the tweet
  late DateTime createdAt; ///The dateTime at which the tweet was posted
  String? tweetUrl; ///The url to the tweet on Twitter //todo implement
  bool? isTruncated; /// Boolean for if the tweet text was cut because the tweet was longer than 140 characters
  late bool isFavourite; ///Boolean for if the tweet has been favourited (liked)
  late bool isRetweeted; ///Boolean for if the tweet has been retweeted
  late bool isPossiblySensitive; ///Boolean for if the tweet may contain sensitive content
  List<dynamic>? characterRange; ///The range for the number of characters in the tweet
  List<String?> mediaType = []; ///The type of media in the tweet
  List<String?> media = []; ///List of the url for the various media in the tweet

  String? filterLevel; ///The filter level of the tweet
  String? language; ///The language in which the tweet was made
  // matching rules

  //extended entities
  //entities
  late int favouriteCount; ///Number of times the tweet has been fovourited (liked)
  late int retweetCount; ///Number of times the tweet has been retweeted
  late int replyCount; ///Number of times the tweet has been replied to (commented)
  late int quoteCount; ///Number of times the tweet has been quoted



  Tweet({
    required this.id,
    required this.twitterUser,
    this.text,
    required this.createdAt,
    this.tweetUrl,
    this.isTruncated,
    required this.isFavourite,
    required this.isRetweeted,
    required this.isPossiblySensitive,
    this.characterRange,
    dynamic entities,
    this.filterLevel,
    this.language,
  required this.favouriteCount,
  required this.retweetCount,
  required this.replyCount,
  required this.quoteCount,
}){
    if (entities != null  && entities.containsKey("media"))
      for (dynamic m in entities["media"]) {
        media.add(m["media_url"]);
        mediaType.add(m["type"]);
    }
  }


//todo change the images in the object to media and let the set image/media check from entities if the media type is a video or a photo


  //                  SETTERS

  ///Creates and returns a [Tweet] object from the json data [map]
  factory Tweet.fromMap(Map<dynamic, dynamic> map){
    return Tweet(
      createdAt : convertTwitterDate(map["retweeted_status"]["created_at"]),
      id : map["retweeted_status"]["id"],
      text : map["retweeted_status"]["full_text"],
      isTruncated : map["retweeted_status"]['truncated'],
      isPossiblySensitive : map["retweeted_status"]["possibly_sensitive"],
      isRetweeted : map["retweeted_status"]["retweeted"],
      isFavourite : map["retweeted_status"]["favorited"],
      language : map["retweeted_status"]["lang"],
      favouriteCount : map["retweeted_status"]["favorite_count"],
      retweetCount : map["retweeted_status"]["retweet_count"],
      replyCount : map["retweeted_status"]["reply_count"],
      twitterUser : TwitterUserTemp().createFromMap(
          Map<String, dynamic>.from(map["retweeted_status"]["user"])),
      characterRange : map["retweeted_status"]['display_text_range'],
      entities: map["entities"], 
        quoteCount: map["quote_count"]
    );

    
      //decomposing tweet url data
      // var temp = Map<String,dynamic>.from(Map<String,dynamic>.from(map["extended_entities"]).values.elementAt(0).elementAt(0)).values.elementAt(5);
      // setTweetURL(temp);

  }



//todo add support for other languages besides english









  // ///Returns a json object containing all the attributes of [Tweet]
  // Map<String,dynamic>? getMap(){
  //   Map<String,dynamic>? map;
  //
  //
  //
  //   return map;
  // }


}


