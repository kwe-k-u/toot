



class TwitterUser{
  String? handle; /// The handle for the account (usually preceded by @)
  String? accountName; /// The name for the account
  String? profileUrl; ///The url to the account's twitter profile
  late int id; ///The ID of the account
  DateTime? createAt; /// The dateTime at which the account was created
  String? description; /// The description created on the account
  String? location; //of type location
  String? profileImageUrl; ///The url to the account's profile image
  bool? isProtected; /// Boolean for if the account is protected
  late bool isVerified; /// Boolean for if the account is verified by Twitter
  late int followerCount; /// The number of accounts following this account
  late int  followingCount; ///The number of accounts followed by this account
  int? listedCount; //The number of lists the account has been added;
  late int tweetCount; /// The number of tweets posted by this account
  //entities


  TwitterUser({

    this.handle,
    this.accountName,
    this.profileUrl,
    required this.id,
    this.createAt,
    this.description,
    this.location,
    this.profileImageUrl,
    this.isProtected,
    required this.isVerified,
    required this.followerCount,
    required this.followingCount,
    this.listedCount,
    required this.tweetCount,
});


  ///Creates a [TwitterUser] from a json object [map]
  factory TwitterUser.fromJson(Map<dynamic, dynamic> map){
    return TwitterUser(
      handle: map["screen_name"],
      accountName: map["name"],
  profileUrl : "",//todo implement
  id : map["id"],
  createAt : map["created_at"],
  description: map["description"],
  location: "",
  profileImageUrl : map["profile_image_url_https"],
  isProtected : false, //todo implement
  isVerified : map["verified"],
  followerCount: map["followers_count"],
  followingCount: map["friends_count"],
  listedCount : 1,//todo implement
  tweetCount : map["statuses_count"],
      );

    }






}