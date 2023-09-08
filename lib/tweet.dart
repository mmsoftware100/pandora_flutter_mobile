
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandora_flutter_mobile/providers/article_provider.dart';
import 'package:pandora_flutter_mobile/providers/comment_provider.dart';
import 'package:pandora_flutter_mobile/providers/shared_preference_provider.dart';
import 'package:pandora_flutter_mobile/providers/user_provider.dart';
import 'package:pandora_flutter_mobile/providers/vote_provider.dart';
import 'package:pandora_flutter_mobile/view/pages/article/update_article_page.dart';
import 'package:pandora_flutter_mobile/view/pages/comments_page.dart';
import 'package:pandora_flutter_mobile/view/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'components/constants.dart';
import 'components/sign_in_needed_alert_dialog.dart';
import 'data/constant/global.dart';
import 'model/user_model.dart';
import 'view/widgets/text_description.dart';


class Tweet extends StatelessWidget {
  final UserModel user;
  final String avatar;
  final String username;
  final String name;
  final String timeAgo;
  final String text;
  final String comments;
  final String heartBroken;
  final String favorites;
  final String articleId;
  final int index;

  Tweet({
        required this.user,
        required this.avatar,
        required this.username,
        required this.name,
        required this.timeAgo,
        required this.text,
        required this.comments,
        required this.heartBroken,
        required this.favorites,
        required this.articleId,
        required this.index

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(),
          tweetBody(context,this.articleId),
        ],
      ),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      /*child: CircleAvatar(
        backgroundImage: NetworkImage(this.avatar),
      ),*/
      child:CachedNetworkImage(
        imageUrl: this.avatar != "photo_url" ? this.avatar : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg",
        imageBuilder: (context, imageProvider) => Container(
          // width: 80.0,
          // height: 80.0,
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.width / 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )
    );
  }

  Widget tweetBody(BuildContext context,String articleId) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(context),
          tweetText(),
          tweetButtons(context,articleId),
        ],
      ),
    );
  }

  Widget tweetHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            this.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
        Text(
          '@$name · $timeAgo',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

         */

        Text(
          '$timeAgo',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Spacer(),
        this.user.id == Provider.of<UserProvider>(context,listen: true).user.id ? IconButton(
          icon: Icon(
            FontAwesomeIcons.bars,
            size: 14.0,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (content)=>UpdateArticlePage(articleId: int.parse(this.articleId), content: this.text,)));
          },
        ) : Container(),
      ],
    );
  }

  Widget tweetText() {
    return text.length < 150 ? Text(
      text,
      style: GoogleFonts.lato(
          color: Colors.grey[600],
          letterSpacing: 1,
          fontSize: newsFontSize,
          fontWeight: FontWeight.normal),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.clip,
    )
        :new DescriptionTextWidget(text: text);
  }

  Widget tweetButtons(BuildContext context, String articleId) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //Comment icon
          InkWell(
              child: tweetIconButton(FontAwesomeIcons.comment, this.comments),
            onTap: () async{

              //Navigator.push(context , MaterialPageRoute(builder: (context)=> CommentsPage(articleId: articleId ,articleIndex: index,)));

              showFlexibleBottomSheet(
                minHeight: 0,
                initHeight: 0.8,
                maxHeight: 0.8,
                context: context,
                builder: _buildBottomSheet,
                isExpand: false,
              );



              /*
                String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;

              bool status = await Provider.of<CommentProvider>(context, listen: false).getComment(accessToken!,int.parse(articleId));

              print("Text Page Get Comment list is "+Provider.of<CommentProvider>(context,listen: false).commentList.toString());

              if(status == true)
                Navigator.push(context , MaterialPageRoute(builder: (context)=> CommentsPage(articleId: articleId )));

               */

            },
          ),
          // tweetIconButton(FontAwesomeIcons.retweet, this.retweets),
          // tweetIconButton(FontAwesomeIcons.heart, this.favorites),

          //down vote icon
          Provider.of<ArticleProvider>(context,listen: true).articleList[this.index].userVote != 0 ?InkWell(
              child: tweetIconButton(FontAwesomeIcons.thumbsDown, this.heartBroken),
          onTap:()async{

            await Provider.of<SharedPreferenceProvider>(context,listen:  false).getSahredPreferenesData();
            String username = Provider.of<SharedPreferenceProvider>(context,listen:  false).userName;
            String password = Provider.of<SharedPreferenceProvider>(context,listen:  false).password;


            if(username == "" || password == ""){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));
              MyAlertDialog.ShowDialog(context);

            }
            else{

              bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: username!, password: password!);

              if(Provider.of<ArticleProvider>(context,listen: false).articleList[this.index].userVote ==-1){
                Provider.of<ArticleProvider>(context,listen: false).voteReaction(articleIndex: this.index, voteType: 0);

                //0 for down vote and 1 for up vote


                String  accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                String articleId = Provider.of<ArticleProvider>(context,listen: false).articleList[this.index].id.toString();

                bool status = await Provider.of<VoteProvider>(context, listen: false).createVote(accessToken!,articleId, "0");
                print(" create down Vote is "+status.toString());
              }
            }
          }) : tweetIconButton(FontAwesomeIcons.solidThumbsDown, this.heartBroken),

          // up vote icon
          Provider.of<ArticleProvider>(context,listen: true).articleList[this.index].userVote != 1 ? InkWell(
              child: tweetIconButton(FontAwesomeIcons.thumbsUp, this.favorites),
            onTap: ()async{

              await Provider.of<SharedPreferenceProvider>(context,listen:  false).getSahredPreferenesData();
              String username = Provider.of<SharedPreferenceProvider>(context,listen:  false).userName;
              String password = Provider.of<SharedPreferenceProvider>(context,listen:  false).password;
              if(username == "" || password == ""){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));
                MyAlertDialog.ShowDialog(context);

              }
              else{

                bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: username!, password: password!);

                if(Provider.of<ArticleProvider>(context,listen: false).articleList[this.index].userVote ==-1){
                  Provider.of<ArticleProvider>(context,listen: false).voteReaction(articleIndex: this.index, voteType: 1);

                  //0 for down vote and 1 for up vote


                  String  accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                  String articleId = Provider.of<ArticleProvider>(context,listen: false).articleList[this.index].id.toString();

                  bool status = await Provider.of<VoteProvider>(context, listen: false).createVote(accessToken!,articleId, "1");
                  print(" create up Vote is "+status.toString());
                }
              }
            },
          ): tweetIconButton(FontAwesomeIcons.solidThumbsUp, this.favorites),
          // tweetIconButton(FontAwesomeIcons.share, ''),
        ],
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: parseColor("#69001e"),
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    // return Material(
    //   child: Container(
    //     child: ListView(
    //         controller: scrollController,
    //         shrinkWrap: true,
    //     ),
    //   ),
    // );

    return CommentsPage(articleId: this.articleId, articleIndex: this.index);
  }
}
