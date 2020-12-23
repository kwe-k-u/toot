

import 'package:twitter_tweets_ui/resources.dart';

class TwitterUserTemp{
  String _userHandle;
  String _userAccountName;
  String __profileUrl;
  String _userId;
  DateTime _createAt;
  String _description;
  String _location; //of type location
  String _profileImageUrl;
  bool _isProtected;
  bool _isVerified;
  int _followerCount; //these come from public_metrics
  int _followingCount;
  int _listedCount;
  int _tweetCount;
  //entities


  ///Creates a [TwitterUserTemp] from a json object [map]
  TwitterUserTemp createFromMap(Map<String,dynamic> map) {
    if (map.keys.length <3) {
      findUser(map["id"].toString()).then((value) {
        map = value;

        setUserHandle(map["screen_name"]);
        setUserId(map["id"].toString());
        setUserName(map["name"]);
        setDescription(map["description"]);
        setCreatedDate(map["created_at"]);
        setUserName(map["name"]);
        setFollowersCount(map["followers_count"]);
        setFollowingCount(map["friends_count"]);
        setVerifiedStatus(map["verified"]);
        setTweetCount(map["statuses_count"]);
        setProfileImageUrl(map["profile_image_url"]);
        // setCreatedDate(convertTwitterDate(map["created_at"]));
      });

      return this;

    } else {
      setUserHandle(map["screen_name"]);
      setUserId(map["id"].toString());
      setUserName(map["name"]);
      setDescription(map["description"]);
      setCreatedDate(map["created_at"]);
      setUserName(map["name"]);
      setFollowersCount(map["followers_count"]);
      setFollowingCount(map["friends_count"]);
      setVerifiedStatus(map["verified"]);
      setTweetCount(map["statuses_count"]);
      setProfileImageUrl(map["profile_image_url"]);
      // setCreatedDate(convertTwitterDate(map["created_at"]));

      return this;
    }

  }


  ///Sets the account name of [TwitterUserTemp] to [name]
  void setUserName(String name){
    this._userAccountName = name;
  }



  ///Sets the user handle of [TwitterUserTemp] to [handle]
  void setUserHandle(String handle){
    this._userHandle = handle;
  }


  ///Sets the link to the Twitter profile as [url]
  void setProfileUrl(String url){
    this.__profileUrl = url;
  }


  ///Sets the url of the Twitter profile's image to [url]
  void setProfileImageUrl(String url){
    this._profileImageUrl = url;
  }


  ///Sets the account id of [TwitterUserTemp] to [id]
  void setUserId(String id){
    this._userId = id;
  }


  ///Sets the date of creation of the twitter account to [date]
  void setCreatedDate(dynamic date){
    if (date.runtimeType == String){
      this._createAt = DateTime.now();
      // this._createAt = convertTwitterDate(date);
    } else if (date.runtimeType == DateTime){
      this._createAt = date;
    }
  }


  ///Sets the profile description of the Twitter account to [description]
  void setDescription(String description){
    this._description = description;
  }


  ///Sets the location of the twitter account as the string [location]
  void setLocation(String location){
    this._location = location;
  }


  ///Sets the protected status of the twitter account to [status]
  void setProtectedStatus(bool status){
    this._isProtected = status;
  }


  ///Sets the verified status of the twitter account to [status]
  void setVerifiedStatus(bool status){
    this._isVerified = status;
  }


  ///Sets the number of followers of [TwitterUserTemp] to [count]
  void setFollowersCount(int count){
    this._followerCount = count;
  }


  ///Sets the number of accounts followed by [TwitterUserTemp] to [count]
  void setFollowingCount(int count){
    this._followingCount = count;
  }


  ///Sets the number of tweets of [TwitterUserTemp] to [count]
  void setTweetCount(int count){
    this._tweetCount = count;
  }












  ///Returns the account handle of [TwitterUserTemp] as a string
  String getUserHandle()
  => "@${this._userHandle}" ?? "";

  ///Returns the account name of [TwitterUserTemp] as a string
  String getAccountName()
  => this._userAccountName ?? "";

  ///Returns the url to the twitter profile of [TwitterUserTemp]
  String getProfileUrl()
  => this.__profileUrl ?? "";


  ///Returns the url to the profile image of the twitter account
  String getProfileImageUrl()
  => this._profileImageUrl ?? "";



  ///Returns the Twitter account id of [TwitterUserTemp] as a string
  String getUserId()
  => this._userId ?? "";

  ///Returns the date of creation of the Twitter account of [TwitterUserTemp]
  DateTime getDateCreated()
  => this._createAt;

  ///Returns the description of the twitter account of [TwitterUserTemp]
  String getDescription()
  => this._description ?? "";


  ///Returns the location of the twitter account of [TwitterUserTemp] as a string
  String getLocation()
  => this._location ?? "";



  ///Returns a boolean to show if the twitter account is protected
  bool isProtected()
  => this._isProtected ?? false;

  ///Returns a boolean to show if the twitter account is verified
  bool isVerified()
  => this._isVerified ?? false;

  ///Returns the number of followers of the twitter account
  int getFollowerCount()
  => this._followerCount;

  ///Returns the number of accounts that the twitter account follows
  int getFollowingCount()
  => this._followingCount;


  int getListedCount()
  => this._listedCount;

  ///Returns the number of tweets by [TwitterUserTemp]
  int getTweetCount()
  => this._tweetCount;





}