import 'package:twitter_tweets_ui/Objects/TwitterUserTemp.dart';
import 'package:twitter_tweets_ui/resources.dart';

class TwitterPostTemp{
  String _idString;
  TwitterUserTemp _user;
  String _tweetText;
  DateTime _createdAt;
  String _tweetUrl;
  bool _isTruncated; /// boolean to show if the tweet text was cut because the tweet was longer than 140 characters
  bool _isFavourite;
  bool _isRetweeted;
  bool _isPossiblySensitive;
  List<dynamic> _tweetCharacterRange;
  String _mediaType;
  List<String> _media = [];

  String _filterLevel;
  String _language;
  // matching rules

  //extended entities
  //entities
  int _favouriteCount;
  int _retweetCount;
  int _replyCount;
  int _quoteCount;



//todo change the images in the object to media and let the set image/media check from entities if the media type is a video or a photo


  //                  SETTERS

  ///Creates and returns a [TwitterPostTemp] object from the json data [map]
  TwitterPostTemp createFromMap(Map<dynamic, dynamic> map){

    //Runs if the tweet has been retweeted. helps replace authenticated user metrics with original tweet metrics
    if (map["retweeted"]) {
      setDatePosted(map["retweeted_status"]["created_at"]);
      // print("asdf created 1 ${map["retweeted_status"]["created_at"]}");

      setTweetId(map["retweeted_status"]["id"]);
      setRetweetedStatus(map["retweeted_status"]["retweeted"]);

      setTweetText(map["retweeted_status"]["full_text"]);
      setTruncatedStatus(map["retweeted_status"]['truncated']);
      setIsSensitiveStatus(map["retweeted_status"]["possibly_sensitive"]);
      setLanguage(map["retweeted_status"]["lang"]);
      setFavouriteStatus(map["retweeted_status"]["favorited"]);
      setFavouriteCount(map["retweeted_status"]["favorite_count"]);
      setRetweetCount(map["retweeted_status"]["retweet_count"]);
      setReplyCount(map["retweeted_status"]["reply_count"]);
      setUser(TwitterUserTemp().createFromMap(
          Map<String, dynamic>.from(map["retweeted_status"]["user"])));
      setTweetCharacterRange(map["retweeted_status"]['display_text_range']);

      if (map["retweeted_status"]["entities"].containsKey("media")){
        setMedia(map["retweeted_status"]["entities"]["media"][0]["media_url"].toString(), map["retweeted_status"]["entities"]["media"][0]["type"]);
      }


    } else {
      //Runs if tweet is current user's own tweet
      setDatePosted(map["created_at"]);

      setTweetId(map["id"]);
      setRetweetedStatus(map["retweeted"]);

      setTweetText(map["full_text"]);
      setTruncatedStatus(map['truncated']);
      setIsSensitiveStatus(map["possibly_sensitive"]);
      setLanguage(map["lang"]);
      setFavouriteStatus(map["favorited"]);
      setFavouriteCount(map["favorite_count"]);
      setRetweetCount(map["retweet_count"]);
      setReplyCount(map["reply_count"]);
      setUser(TwitterUserTemp().createFromMap(
          Map<String, dynamic>.from(map["user"])));
      setTweetCharacterRange(map['display_text_range']);

      if (map["entities"].containsKey("media")){
        setMedia(map["entities"]["media"][0]["media_url"], map["entities"]["media"][0]["type"]);
      }


      //decomposing tweet url data
      // var temp = Map<String,dynamic>.from(Map<String,dynamic>.from(map["extended_entities"]).values.elementAt(0).elementAt(0)).values.elementAt(5);
      // setTweetURL(temp);


    }

    return this;
  }

  ///Sets the tweet ID of [TwitterPostTemp] to [id]
  void setTweetId(dynamic id){
    this._idString = id.toString();
  }


///Sets the date of posting of [TwitterPostTemp] to [date]
  void setDatePosted(dynamic date){
    if (date.runtimeType == String){
        this._createdAt = convertTwitterDate(date);
    // print("asdf ${this._createdAt}");
    }
    else if (date.runtimeType == DateTime)
      this._createdAt = date;
  }


  ///Sets the number of characters of in [_tweetText] to the range [range]
  void setTweetCharacterRange(List<dynamic> range){
    this._tweetCharacterRange = range;
  }
  

///Sets the account with which [TwitterPostTemp] was posted to [user]
  void setUser(TwitterUserTemp user){
    this._user = user;
  }

  ///Sets the text of [TwitterPostTemp] to [text]
  void setTweetText(String text){
    this._tweetText = text; //todo add checker to keep length 140 characters
  }

  /// Sets the
  void setFavouriteStatus(bool status){
    this._isFavourite = status;
  }

  void setRetweetedStatus(bool status){
    this._isRetweeted = status;
  }

  ///Sets the possibly sensitive status of [TwitterPostTemp] to [status]
  void setIsSensitiveStatus(bool status){
    this._isPossiblySensitive = status;
  }

  ///Sets the truncated status of [TwitterPostTemp] to [status]
  void setTruncatedStatus(bool status){
    this._isTruncated = status;
  }

  ///Sets the url to the tweet to [url]
  void setTweetURL(String url){
    this._tweetUrl = url;
  }

  ///Sets the number of favourites of [TwitterPostTemp] to [count]
  void setFavouriteCount(int count){
    this._favouriteCount = count;
  }

///Sets the number of retweets of [TwitterPostTemp] to [count]
  void setRetweetCount(int count){
    this._retweetCount = count;
  }


  ///Sets the number of replies to [TwitterPostTemp] to [count]
  void setReplyCount(int count){
    this._replyCount = count;
  }


  ///Sets the number of quoted tweets of [TwitterPostTemp] to [count]
  void setQuoteCount (int count){
    this._quoteCount = count;
  }


  ///Sets the language of [TwitterPostTemp] to [lang]
  void setLanguage(String lang){
    this._language = lang;
  }


  ///Sets the filter level of [TwitterPostTemp] to [level]
  void setFilterLevel(String level){
    this._filterLevel = level;
  }


  void setMedia(String url, String type){
    this._mediaType = type;
    this._media.add(url);
  }
//todo add support for other languages besides english







  //                    GETTERS

  ///Returns the date [TwitterPostTemp] was posted on Twitter
  DateTime getDateCreated()
  => this._createdAt;


///Returns the user who posted [TwitterPostTemp] as a [TwitterUserTemp] object
  TwitterUserTemp getUser(){
    return this._user;
  }


  ///Returns the id of the tweet [TwitterPostTemp] as a string
  String getTweetId()
  => this._idString;


  ///Returns the text of the tweet
  String getTweetText(){
    return this._tweetText;
  }


  ///Returns a boolean to show the truncation status of [TwitterPostTemp]
  bool isTruncated()
  => this._isTruncated;

  ///Returns a boolean to show the if the post has been marked as favourite
  bool isFavourite(){
    return this._isFavourite;
  }

  ///Returns the url of the tweet [TwitterPostTemp]
  String getTweetURL()
  => this._tweetUrl;

  ///Returns a boolean to show if the tweet [TwitterPostTemp] has been retweeted
  bool isRetweeted()
  => this._isRetweeted;


  ///Returns a boolean to show if the tweet [TwitterPostTemp] contains sensitive material
  bool isSensitive()
  => this._isPossiblySensitive;


  ///Returns the number of likes the tweet has
  int getFavouriteCount()
  => this._favouriteCount;

  ///Returns the number of retweets the tweet has
  int getRetweetCount()
  => this._retweetCount;

  ///Returns the number of comments or replies the tweet has
  int getReplyCount()
  => this._replyCount;

  ///Returns the number of quoted tweets the tweet has
  int getQuoteCount()
  => this._quoteCount;


  ///Returns teh filter level of the tweet as a string
  String getFilterLevel()
      => this._filterLevel;

  ///Returns the language of the tweet as shorthand String
  String getLanguage()
  => this._language;
  

  ///Returns a list showing the number of characters in the tweet
  List<dynamic> getTweetCharacterRange()
  => this._tweetCharacterRange;







  String getMediaType()
  => this._mediaType;


  List<String> getMediaUrl()
  => this._media;


  ///Returns a json object containing all the attributes of [TwitterPostTemp]
  Map<String,dynamic> getMap(){
    Map<String,dynamic> map;



    return map;
  }


}


