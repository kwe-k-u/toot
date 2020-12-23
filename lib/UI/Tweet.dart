

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:twitter_api/Objects/TwitterPostTemp.dart';
import 'package:twitter_api/utlils/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class TweetWidget extends StatelessWidget {

  final TwitterPostTemp temp;

  TweetWidget(this.temp);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        if (await canLaunch(temp.getTweetURL())) {
        await launch(
        temp.getTweetURL(),
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
        );
        } else {
        throw 'Could not launch ${temp.getTweetURL()}';
        }

      },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child:
                Image.network(temp.getUser().getProfileImageUrl(), ),
              ),
              title: Column(
                children: [
                  Text("${temp.getUser().getAccountName()} \t${temp.getUser().getUserHandle()}\t ${timeCreated(temp.getDateCreated())} "),

                  //todo add support for multiple images and video
                  temp.getMediaType() == "photo" ?
                    Image.network(temp.getMediaUrl()[0], scale: 9,)
                      :
                      Container()

                ],
              ),
              trailing: Icon(Zocial.twitter, size: 20.0,),
              subtitle: Text(temp.getTweetText()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        onPressed: (){}),
                    Text(statText(temp.getReplyCount()))
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                        icon: Icon(AntDesign.retweet),
                        color: temp.isRetweeted() ? Colors.green : Colors.black,

                        onPressed: (){}),
                    Text(statText(temp.getRetweetCount()))
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                        icon: Icon(EvilIcons.heart),
                        color: temp.isFavourite() ? Colors.red : Colors.black,
                        onPressed: (){}),
                    Text(statText(temp.getFavouriteCount())),

                  ],
                ),

                IconButton(
                    icon: Icon(Icons.share),
                    onPressed: (){
                    }), //todo add share option

                Spacer(),
              ],
            ),
            Divider(thickness: 1.4,)
          ],
        )
    );
  }

}
