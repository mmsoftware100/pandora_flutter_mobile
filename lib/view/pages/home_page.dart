import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/constants.dart';
import '../../components/custom_fuction.dart';
import '../../data/constant/global.dart';
import '../../providers/article_provider.dart';
import '../../providers/user_provider.dart';
import '../../tweet.dart';
import '../../tweets.dart';
import '../widgets/image_view_widget.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/text_description.dart';
import '../widgets/video_view_widget.dart';
import 'comments_page.dart';
import 'create_article_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _enablePullDown = true; // this enable our app to able to pull down
  RefreshController _refreshController = RefreshController(); // the refresh controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/pandora_box.png'),
          ),
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // body: listOfTweets(),

      // So inside the body widget we will implement pull to refresh, So first we call
      body: SmartRefresher(
        enablePullUp: true,
        enablePullDown: _enablePullDown, // the bool we create, so this gave access to be able to pull the app down
        header: WaterDropHeader(
          waterDropColor: Colors.teal,
// complete: If the refresh is completed show this else failed
          complete: Text('Complete',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight
                      .bold)), // you can customize this whatever you like
          failed:
          Text('Failed', style: TextStyle(color: Colors.red, fontSize: 18)),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh, // we are going to inplement _onRefresh and _onLoading below our build method
        onLoading: _onLoading,
        child: Provider.of<ArticleProvider>(context, listen: true).articleList.length == 0 ? Center(
          child: Text("No data".tr()),
        ):
        listOfArticles(),// we are going to create a list of text in this dynamic ii()
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: parseColor("#69001e"),
        child: Icon(FontAwesomeIcons.envelope,color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateArticlePage()));
        },
      ),
      /*
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildBottomIconButton(Icons.home, parseColor("#69001e")),
            buildBottomIconButton(Icons.search, parseColor("#69001e")),
            buildBottomIconButton(Icons.notifications, parseColor("#69001e")),
            buildBottomIconButton(Icons.mail_outline, parseColor("#69001e")),
          ],
        ),
      ),

       */
    );
  }

  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the footer state to idle
  }

  _onRefresh() async{
    setState(() {
      Future<int> a =
      CustomFunction().checkInternetConnection(); // check internet access
      a.then((value) {
        if (value == 0) {
          CustomFunction().showToast(
              message:
              'No Internet Connection'); // will show a toast if there is no internet
        } else {
          // RefreshPage(); // if you want to refresh the whole page you can put the page name or
          //txtlist(); // if you only want to refresh the list you can place this, so the two can be inside setState


          _refreshController.refreshCompleted();
// request complete,the header will enter complete state,
// resetFooterState : it will set the footer state from noData to idle
        }
      });
    });
    await Provider.of<ArticleProvider>(context,listen: false).getArticle();

  }

  Widget buildBottomIconButton(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {},
    );
  }

  Widget listOfTweets() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return tweets[index];
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
        ),
        itemCount: tweets.length,
      ),
    );
  }

  Widget listOfArticles(){
    return Container(
      color: Colors.white,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          // return tweets[index];
          return  Tweet(
            // avatar: 'https://pbs.twimg.com/profile_images/1187814172307800064/MhnwJbxw_400x400.jpg',
            avatar:Provider.of<ArticleProvider>(context,listen: true).articleList[index].user!.photoUrl,
            username: Provider.of<ArticleProvider>(context,listen: true).articleList[index].user!.name,
            name: 'FlutterDev',
            timeAgo: Provider.of<ArticleProvider>(context,listen: true).articleList[index].createdAt.split(".").first,
            text: Provider.of<ArticleProvider>(context,listen: true).articleList[index].content,
            comments:  Provider.of<ArticleProvider>(context,listen: true).articleList[index].commentCount.toString(),
            heartBroken:  Provider.of<ArticleProvider>(context,listen: true).articleList[index].downVote.toString(),
            favorites: Provider.of<ArticleProvider>(context,listen: true).articleList[index].upVote.toString(),
            articleId: Provider.of<ArticleProvider>(context,listen: true).articleList[index].id.toString(),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
        ),
        itemCount: Provider.of<ArticleProvider>(context,listen: true).articleList.length,
      ),
    );
  }
}