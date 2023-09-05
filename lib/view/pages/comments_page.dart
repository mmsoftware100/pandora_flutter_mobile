import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/loader.dart';
import '../../model/comment_model.dart';
import '../../providers/article_provider.dart';
import '../../providers/comment_provider.dart';
import '../../providers/user_provider.dart';

class CommentsPage extends StatefulWidget {
  String articleId;
  CommentsPage({Key? key,required this.articleId}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _commentController = TextEditingController();
  ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
          child: Stack(children: [
            Positioned(
                top:0,bottom:70,left:0, right:0,
                child:Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child:Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            // Scroll Controller for functionality
                            controller: listScrollController,
                            children: Provider.of<CommentProvider>(context,listen: true).commentList.map((e){
                              /*
                              return Card(
                                child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.content.toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.createdAt.split('.').first.replaceAll('T', " "),style: TextStyle(color: Colors.grey),),
                                          )
                                        ],
                                      ),
                                    )),
                              );

                               */
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.all(10.0),
                                          /*child: CircleAvatar(
        backgroundImage: NetworkImage(this.avatar),
      ),*/
                                          child:CachedNetworkImage(
                                            imageUrl: e.user!.photoUrl,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5.0),
                                                  child: Text(
                                                    e.user!.name,
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
                                                  e.createdAt.split(".").first,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                /*
                                                IconButton(
                                                  icon: Icon(
                                                    FontAwesomeIcons.angleDown,
                                                    size: 14.0,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () {},
                                                ),

                                                 */
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                e.content,
                                                style: TextStyle(fontSize: 14,color: Colors.white),
                                                overflow: TextOverflow.clip,
                                              ),
                                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                              width: 200,
                                              decoration:
                                              BoxDecoration(color: Color(0xffaeaeae), borderRadius: BorderRadius.circular(8)),
                                              margin: EdgeInsets.only(left: 10),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                    )
                )
            ),

            Positioned(  //position text field at bottom of screen

                bottom: 0, left:0, right:0,
                // child: Container(
                //     color: Colors.black12,
                //     height: 70,
                //     child: Row(children: [
                //
                //       Expanded(
                //           child: Container(
                //             margin: EdgeInsets.all(10),
                //             child: TextField(
                //               controller: msgtext,
                //               decoration: InputDecoration(
                //                   hintText: "Enter your Message"
                //               ),
                //             ),
                //           )
                //       ),
                //
                //       Container(
                //           margin: EdgeInsets.all(10),
                //           child: ElevatedButton(
                //             child:Icon(Icons.send),
                //             onPressed: (){
                //               if(msgtext.text != ""){
                //                 sendmsg(msgtext.text, recieverid); //send message with webspcket
                //               }else{
                //                 print("Enter message");
                //               }
                //             },
                //           )
                //       )
                //     ],)
                // ),
                child:buildInput()
            )
          ],)
      ),
    );
  }


  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          /*
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: (){

                  }

              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: (){

                },

              ),
            ),
            color: Colors.white,
          ),

          */
          // Edit text
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                  onSubmitted: (value) {

                  },
                  style: TextStyle( fontSize: 15),
                  controller: _commentController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                  ),
                  // focusNode: focusNode,
                  // autofocus: true,
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: ()async{
                  print("comment create");

                  if(_commentController.text.length > 0){
                    int userId = Provider.of<UserProvider>(context, listen:  false).user.id;
                    print(userId);
                    String accessToke = Provider.of<UserProvider>(context, listen: false).user.accessToken;
                    //String articleId = Provider.of<ArticleProvider>(context, listen: false).articleList[int.parse(widget.articleId)].id.toString();
                    print(widget.articleId);
                    Provider.of<CommentProvider>(context, listen: false).addComment(articleId: int.parse(widget.articleId), userId: userId, comment: _commentController.text, user: Provider.of<UserProvider>(context, listen:  false).user);

                    // show loading indicator
                    Dialogs.showLoadingDialog(context, _keyLoader);

                    await Provider.of<CommentProvider>(context, listen:  false).createComment(accessToke, widget.articleId, _commentController.text);

                    // hide loading indicator
                    Navigator.pop(context);

                    _commentController.clear();
                  }



                  if (listScrollController.hasClients) {
                    final position = listScrollController.position.maxScrollExtent;
                    listScrollController.animateTo(
                      position,
                      duration: Duration(seconds: 3),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide( width: 0.5)), color: Colors.white),
    );
  }

}
