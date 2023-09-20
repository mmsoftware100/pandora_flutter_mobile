import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/color_constants.dart';
import '../../components/loader.dart';
import '../../components/sign_in_needed_alert_dialog.dart';
import '../../model/comment_model.dart';
import '../../providers/article_provider.dart';
import '../../providers/comment_provider.dart';
import '../../providers/shared_preference_provider.dart';
import '../../providers/user_provider.dart';
import 'login_page.dart';

class CommentsPage extends StatefulWidget {
  String articleId;
  int articleIndex;
  CommentsPage({Key? key,required this.articleId,required this.articleIndex}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _commentController = TextEditingController();
  ScrollController listScrollController = ScrollController();
  bool getCommentStatus = false;

  /*
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? userName ="";
  String? password ="";

  getSahredPreferenesData() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      userName = (prefs.getString('username') ?? "");
      password = (prefs.getString('password') ?? "");

    });

    print("userName is "+userName!);
  }

   */

  getComment()async{
    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    bool status = await Provider.of<CommentProvider>(context, listen: false).getComment(accessToken!,int.parse(widget.articleId));
    setState(() {
      getCommentStatus = status;
    });

    print("Text Page Get Comment list is "+Provider.of<CommentProvider>(context,listen: false).commentList.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    getComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      // ),
      body: getCommentStatus == false ?  ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardLoading(
                height: 30,
                width: size.width * .2,
                padding: const EdgeInsets.only(bottom: 10),
                borderRadius: 15,
              ),
              CardLoading(
                height: size.height * .15,
                padding: const EdgeInsets.only(bottom: 10),
                borderRadius: 15,
              ),
              CardLoading(
                height: size.height * .1,
                padding: const EdgeInsets.only(bottom: 20),
                borderRadius: 15,
              ),
            ],
          );
        },
      )
          : Provider.of<CommentProvider>(context,listen: true).commentList != [] ?
          /*
      SafeArea(
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
                                            imageUrl: e.user!.photoUrl != "photo_url" ? e.user!.photoUrl : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg",
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
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /*
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


                                                      // Spacer(),
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

                                                   */
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
                                                  Container(
                                                    child: Text(
                                                      e.content,
                                                      style: TextStyle(fontSize: 14,color: Colors.white),
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                    //padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                    // width: 200,
                                                    //decoration:
                                                    //BoxDecoration(color: Color(0xffaeaeae), borderRadius: BorderRadius.circular(8)),
                                                    //margin: EdgeInsets.only(left: 10),
                                                  ),                                            ],
                                              ),
                                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                              // width: 200,
                                              decoration:
                                              BoxDecoration(color: Color(0xffaeaeae), borderRadius: BorderRadius.circular(8)),
                                              margin: EdgeInsets.only(left: 10),
                                            ),
                                            Text(
                                              e.createdAt.split(".").first,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
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
      )

           */

      SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Input content
                buildInput(),

              ],
            ),

            // Loading
            buildLoading()
          ],
        ),
      )
          : Container(),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: Provider.of<CommentProvider>(context,listen: true).commentList.length > 0
          ? ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) => buildItem(index, Provider.of<CommentProvider>(context,listen: true).commentList[index]),
        itemCount: Provider.of<CommentProvider>(context,listen: true).commentList.length,
        // reverse: true,
        controller: listScrollController,
      )
          : Center(
        child: Text("There's no comment, write your first comment!"),
      ),
    );
  }

  Widget buildItem(int index, CommentModel document) {
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
                  imageUrl: document.user!.photoUrl != "photo_url" ? document.user!.photoUrl : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg",
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
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


                                                      // Spacer(),
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

                                                   */
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            document.user!.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            document.content,
                            style: TextStyle(fontSize: 14,color: Colors.white),
                            overflow: TextOverflow.clip,
                          ),
                          //padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          // width: 200,
                          //decoration:
                          //BoxDecoration(color: Color(0xffaeaeae), borderRadius: BorderRadius.circular(8)),
                          //margin: EdgeInsets.only(left: 10),
                        ),                                            ],
                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    // width: 200,
                    decoration:
                    BoxDecoration(color: Color(0xffaeaeae), borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                  ),
                  Text(
                    document.createdAt.split(".").first,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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

                  await Provider.of<SharedPreferenceProvider>(context,listen:  false).getSahredPreferenesData();
                  String username = Provider.of<SharedPreferenceProvider>(context,listen:  false).userName;
                  String password = Provider.of<SharedPreferenceProvider>(context,listen:  false).password;

                  if(username == "" || password == ""){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));
                    MyAlertDialog.ShowDialog(context);

                  }
                  else{
                    bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: username, password: password);

                    if(loginStatus == true){
                      if(_commentController.text.length > 0){
                        int userId = Provider.of<UserProvider>(context, listen:  false).user.id;
                        print(userId);
                        String accessToke = Provider.of<UserProvider>(context, listen: false).user.accessToken;
                        //String articleId = Provider.of<ArticleProvider>(context, listen: false).articleList[int.parse(widget.articleId)].id.toString();
                        print(widget.articleId);
                        Provider.of<CommentProvider>(context, listen: false).addComment(articleId: int.parse(widget.articleId), userId: userId, comment: _commentController.text, user: Provider.of<UserProvider>(context, listen:  false).user);

                        Provider.of<ArticleProvider>(context,listen: false).increseCommentCount(articleIndex: widget.articleIndex);
                        // show loading indicator
                        Dialogs.showLoadingDialog(context, _keyLoader);

                        await Provider.of<CommentProvider>(context, listen:  false).createComment(accessToke, widget.articleId, _commentController.text);

                        // hide loading indicator
                        Navigator.pop(context);

                        _commentController.clear();
                      }
                    }
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

  Widget buildLoading() {
    return Positioned(
      child: SizedBox.shrink(),
    );
  }


}
