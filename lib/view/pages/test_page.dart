import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/data/constant/const.dart';
import 'package:provider/provider.dart';

import '../../providers/article_provider.dart';
import '../../providers/comment_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/vote_provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  String? accessToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),

      body: ListView(
        children: [
          ListTile(
            title: Text("Login"),
            onTap: (){
              login();
            },
          ),
          ListTile(
            title: Text("Get Article"),
            onTap: (){
              getArticle();
            },
          ),
          ListTile(
            title: Text("Create Article"),
            onTap: (){
              createArticle();
            },
          ),
          ListTile(
            title: Text("Update Article"),
            onTap: (){
              updateArticle();
            },
          ),
          ListTile(
            title: Text("Create Comment"),
            onTap: (){
              createComment();
            },
          ),

          ListTile(
            title: Text("Get Comment"),
            onTap: (){
              getComment();
            },
          ),
          ListTile(
            title: Text("Create Vote"),
            onTap: (){
              createVote();
            },
          ),



        ],
      ),
    );
  }

  void login()async{
    await Provider.of<UserProvider>(context,listen: false).login(email: defaultEmail, password: defaultPassword);
    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    print("Test page login access Token is "+accessToken!);
  }

  void getArticle() async{
    int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,currentPage!);
    print("Text Page Get Article list is "+Provider.of<ArticleProvider>(context,listen: false).articleList.toString());
  }

  void createArticle() async{
    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    await Provider.of<ArticleProvider>(context, listen: false).createAritcle(accessToken!, "Test Page Title", "Test Page Content");
    print("Text Page create Article list is "+Provider.of<ArticleProvider>(context,listen: false).articleList.toString());
  }

  void updateArticle() async{
    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    await Provider.of<ArticleProvider>(context, listen: false).updateAritcle(accessToken!, "Test Page Title"+DateTime.now().toString(), "Test Page Content"+DateTime.now().toString(),13);
    print("Text Page update Article list is "+Provider.of<ArticleProvider>(context,listen: false).articleList.toString());
  }

  void createComment() async{
    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    await Provider.of<CommentProvider>(context, listen: false).createComment(accessToken!, "13", "Test Page Comment"+DateTime.now().toString());
    print("Text Page create comment is "+Provider.of<CommentProvider>(context,listen: false).commentList.toString());
  }

  void getComment() async{
    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    await Provider.of<CommentProvider>(context, listen: false).getComment(accessToken!, 1);
    print("Text Page Get Comment list is "+Provider.of<CommentProvider>(context,listen: false).commentList.toString());
  }


  void createVote() async{

    //0 for down vote and 1 for up vote

    setState(() {
      accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    });
    bool status = await Provider.of<VoteProvider>(context, listen: false).createVote(accessToken!,"13", "1");
    print("Text Page create Vote is "+status.toString());
  }
}
