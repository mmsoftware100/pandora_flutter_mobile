import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/loader.dart';
import '../../model/comment_model.dart';
import '../../providers/article_provider.dart';

class CommentsPage extends StatefulWidget {
  int newsIndex;
  CommentsPage({Key? key,required this.newsIndex}) : super(key: key);

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
        backgroundColor: Colors.pink,
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
                            physics: NeverScrollableScrollPhysics(),
                            // Scroll Controller for functionality
                            controller: listScrollController,
                            children: Provider.of<ArticleProvider>(context, listen: true).articleList.map((e){
                              return Card(
                                child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.title),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.createdAt.split('.').first.replaceAll('T', " "),style: TextStyle(color: Colors.grey),),
                                          )
                                        ],
                                      ),
                                    )),
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
                  /*
                  if(_commentController.text.length > 0){
                    int userId = Provider.of<UserProvider>(context, listen:  false).user.id;
                    print(userId);
                    String accessToke = Provider.of<UserProvider>(context, listen: false).user.accessToken;
                    String outsideNewsId = Provider.of<OutsideNewsProvider>(context, listen: false).outsideNews[widget.newsIndex].id.toString();
                    print(outsideNewsId);
                    Provider.of<OutsideNewsProvider>(context, listen: false).addComment(newsId: Provider.of<OutsideNewsProvider>(context, listen: false).outsideNews[widget.newsIndex].id, userId: userId, comment: _commentController.text, user: Provider.of<UserProvider>(context, listen:  false).user);

                    // show loading indicator
                    Dialogs.showLoadingDialog(context, _keyLoader);

                    await Provider.of<CommentsProvider>(context, listen:  false).createComment(accessToke, outsideNewsId, _commentController.text);

                    // hide loading indicator
                    Navigator.pop(context);

                    _commentController.clear();
                  }

                   */

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
