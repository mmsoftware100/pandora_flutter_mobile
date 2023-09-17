import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandora_flutter_mobile/view/pages/profile_page.dart';
import 'package:pandora_flutter_mobile/view/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';
import '../../components/custom_fuction.dart';
import '../../components/sign_in_needed_alert_dialog.dart';
import '../../data/constant/global.dart';
import '../../providers/article_provider.dart';
import '../../providers/shared_preference_provider.dart';
import '../../providers/user_provider.dart';
import '../../tweet.dart';
import '../../tweets.dart';
import '../widgets/image_view_widget.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/post_widget.dart';
import '../widgets/text_description.dart';
import '../widgets/video_view_widget.dart';
import 'comments_page.dart';
import 'article/create_article_page.dart';
import 'login_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _selectedIndex = 0; //New
  bool _enablePullDown = true; // this enable our app to able to pull down
  RefreshController _refreshController = RefreshController(); // the refresh controller
  int curentPage = 1;
  // String? userName ="";
  // String? password ="";
  //
  // getSahredPreferenesData() async {
  //   final SharedPreferences prefs = await _prefs;
  //   setState(() {
  //     userName = (prefs.getString('username') ?? "");
  //     password = (prefs.getString('password') ?? "");
  //   });
  //
  //   print("userName is "+userName!);
  // }

  _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Log out"),
          content: new Text("Do you quit ?"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Yes"),
              onPressed: ()async{
                await Provider.of<SharedPreferenceProvider>(context,listen: false).saveUserNameAndPassword("", "");
                Provider.of<UserProvider>(context,listen: false).userClear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SplashScreen(title: "")), (route) => false);
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    // getSahredPreferenesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Container(
          margin: const EdgeInsets.all(10.0),
          /*
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/pandora_box.png'),
          ),

           */
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(Provider.of<UserProvider>(context,listen: true).user!.photoUrl != "photo_url" ? Provider.of<UserProvider>(context,listen: false).user!.photoUrl :'https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg'),
              ),
            ),
          ),
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Provider.of<SharedPreferenceProvider>(context,listen:  true).userName != "" ? IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showDialog(context);
            },
          ): Container()
        ],
      ),
      // body: listOfTweets(),

      // So inside the body widget we will implement pull to refresh, So first we call
      body:  listOfArticles(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: parseColor("#69001e"),
        child: Icon(FontAwesomeIcons.pen,color: Colors.white,),
        onPressed: () async{

          await Provider.of<SharedPreferenceProvider>(context,listen:  false).getSahredPreferenesData();
          String username = Provider.of<SharedPreferenceProvider>(context,listen:  false).userName;
          String password = Provider.of<SharedPreferenceProvider>(context,listen:  false).password;


          if(username == "" || password == ""){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));
            MyAlertDialog.ShowDialog(context);

          }
          else{
            bool loginStatus = await Provider.of<UserProvider>(context, listen: false).login(email: username!, password: password!);

            if(loginStatus == true){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateArticlePage()));
            }
          }
        },
      ),

      /*
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildBottomIconButton(Icons.home, parseColor("#69001e"),),
            buildBottomIconButton(Icons.search, parseColor("#69001e")),
            buildBottomIconButton(Icons.notifications, parseColor("#69001e")),
            buildBottomIconButton(Icons.mail_outline, parseColor("#69001e")),
          ],
        ),
      ),

       */
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,         //New
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: Icon(Icons.home),
            icon: ImageIcon(
              AssetImage("assets/pandora_box.png"),
              color: Color(0xFF3A5A98),
            ),
            label: 'Pandora Box',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),



    );
  }


//New
  void _onItemTapped(int index)async {
    await Provider.of<SharedPreferenceProvider>(context,listen:  false).getSahredPreferenesData();
    if(index != 1){
      setState(() {
        _selectedIndex = index;
      });
    }
    else{

      String username = Provider.of<SharedPreferenceProvider>(context,listen:  false).userName;
      String password = Provider.of<SharedPreferenceProvider>(context,listen:  false).password;

      if(username == "" || password == ""){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));

      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));

      }
    }

  }

  _onLoading() async {
    print("on laoding");
    int? numberOfPage = Provider.of<ArticleProvider>(context, listen: false).number_of_page;
    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    if(curentPage! < numberOfPage!){
      setState(() {
        curentPage ++;
      });
      await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,curentPage!);
    }
    _refreshController
        .loadComplete(); // after data returned,set the footer state to idle
  }

  _onRefresh() async{
    print("on refresh");

    setState(() {
      curentPage = 1;
    });
    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
    bool atricleStatus = await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,curentPage!);

    setState(() {
      Future<int> a =
      CustomFunction().checkInternetConnection(); // check internet access
      a.then((value) {
        if (value == 0) {
          CustomFunction().showToast(
              message:
              'No Internet Connection'); // will show a toast if there is no internet
        } else{
          // RefreshPage(); // if you want to refresh the whole page you can put the page name or
          //txtlist(); // if you only want to refresh the list you can place this, so the two can be inside setState



          _refreshController.refreshCompleted();
// request complete,the header will enter complete state,
// resetFooterState : it will set the footer state from noData to idle
        }
      });
    });


  }

  Widget buildBottomIconButton(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {

      },
    );
  }

  /*
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

   */

  Widget listOfArticles(){
    return SmartRefresher(
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
      child: Text("No data"),
    ):
    ListView.separated(
    // physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      // return tweets[index];
      /*
      return  Tweet(
        // avatar: 'https://pbs.twimg.com/profile_images/1187814172307800064/MhnwJbxw_400x400.jpg',
        user: Provider.of<ArticleProvider>(context,listen: true).articleList[index].user!,
        avatar:Provider.of<ArticleProvider>(context,listen: true).articleList[index].user!.photoUrl,
        username: Provider.of<ArticleProvider>(context,listen: true).articleList[index].user!.name,
        name: 'FlutterDev',
        timeAgo: Provider.of<ArticleProvider>(context,listen: true).articleList[index].createdAt.split(".").first,
        text: Provider.of<ArticleProvider>(context,listen: true).articleList[index].content,
        comments:  Provider.of<ArticleProvider>(context,listen: true).articleList[index].commentCount.toString(),
        heartBroken:  Provider.of<ArticleProvider>(context,listen: true).articleList[index].downVote.toString(),
        favorites: Provider.of<ArticleProvider>(context,listen: true).articleList[index].upVote.toString(),
        articleId: Provider.of<ArticleProvider>(context,listen: true).articleList[index].id.toString(),
        index: index,
      );

       */
      return PostWidget(
        article: Provider.of<ArticleProvider>(context,listen: true).articleList[index],
        index: index,
      );
    },
    separatorBuilder: (BuildContext context, int index) => Divider(
    height: 0,
    ),
    itemCount: Provider.of<ArticleProvider>(context,listen: true).articleList.length,
    ),);
  }
}