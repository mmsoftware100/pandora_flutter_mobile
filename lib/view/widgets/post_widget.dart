import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandora_flutter_mobile/view/widgets/text_description.dart';
import 'package:provider/provider.dart';

import '../../components/constants.dart';
import '../../components/sign_in_needed_alert_dialog.dart';
import '../../data/constant/global.dart';
import '../../model/article_model.dart';
import '../../providers/article_provider.dart';
import '../../providers/shared_preference_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/vote_provider.dart';
import '../pages/article/update_article_page.dart';
import '../pages/comments_page.dart';
import '../pages/splash_screen.dart';

class PostWidget extends StatefulWidget {
  ArticleModel article;
  int index;
  PostWidget({Key? key,required this.article,required this.index}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(2.0,2.0,2.0,6),
        child: Card(
          elevation:2.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //user data
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0,2.0,10.0,2.0),
                      child: Container(
                          width: 48,
                          height: 48,
                          child: CachedNetworkImage(
                            imageUrl: widget.article.user!.photoUrl != "photo_url" ? widget.article.user!.photoUrl : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg",
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
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.article.user!.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(widget.article.createdAt,style: TextStyle(fontSize: 16,color: Colors.black87),),
                        ),
                      ],
                    ),
                    Spacer(),
                     IconButton(
                      icon: Icon(
                        FontAwesomeIcons.bars,
                        size: 14.0,
                        color: Colors.grey,
                      ),
                      onPressed: () {

                        showFlexibleBottomSheet(
                          minHeight: 0,
                          initHeight: 0.8,
                          maxHeight: 0.8,
                          context: context,
                          builder: (_,__,___){
                            return Scaffold(
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.report),
                                        title: Text("Report this article"),
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      widget.article.user!.id == Provider.of<UserProvider>(context,listen: true).user.id ? ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text("Update"),
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (content)=>UpdateArticlePage(articleId: int.parse(widget.article.id.toString()), content: widget.article.content,)));
                                        },
                                      ): Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          isExpand: false,
                        );
                      },
                    ) ,
                  ],
                ),

                //content
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,10,4,10),
                  child: widget.article.content.length < 150 ? Text(
                    widget.article.content,
                    style: GoogleFonts.lato(
                        color: Colors.grey[600],
                        letterSpacing: 1,
                        fontSize: newsFontSize,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                  )
                      :new DescriptionTextWidget(text: widget.article.content),
                ),

                //divider
                Divider(height: 2,color: Colors.black,),

                //reaction and comment
                Container(
                  margin: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      //Comment icon
                      InkWell(
                        child: tweetIconButton(FontAwesomeIcons.comment, widget.article.commentCount.toString()),
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
                      widget.article.userVote != 0 ?InkWell(
                          child: tweetIconButton(FontAwesomeIcons.thumbsDown, widget.article.downVote.toString()),
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

                              if(widget.article.userVote ==-1){
                                Provider.of<ArticleProvider>(context,listen: false).voteReaction(articleIndex: widget.index, voteType: 0);

                                //0 for down vote and 1 for up vote


                                String  accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                                String articleId = widget.article.id.toString();

                                bool status = await Provider.of<VoteProvider>(context, listen: false).createVote(accessToken!,articleId, "0");
                                print(" create down Vote is "+status.toString());
                              }
                            }
                          }) : tweetIconButton(FontAwesomeIcons.solidThumbsDown, widget.article.downVote.toString()),

                      // up vote icon
                      widget.article.userVote != 1 ? InkWell(
                        child: tweetIconButton(FontAwesomeIcons.thumbsUp, widget.article.upVote.toString()),
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

                            if(widget.article.userVote ==-1){
                              Provider.of<ArticleProvider>(context,listen: false).voteReaction(articleIndex: widget.index, voteType: 1);

                              //0 for down vote and 1 for up vote


                              String  accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                              String articleId = widget.article.id.toString();

                              bool status = await Provider.of<VoteProvider>(context, listen: false).createVote(accessToken!,articleId, "1");
                              print(" create up Vote is "+status.toString());
                            }
                          }
                        },
                      ): tweetIconButton(FontAwesomeIcons.solidThumbsUp, widget.article.upVote.toString()),
                      // tweetIconButton(FontAwesomeIcons.share, ''),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
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

    return CommentsPage(articleId: widget.article.id.toString(), articleIndex: widget.index);
  }
}
