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
import '../../tweets.dart';
import '../widgets/image_view_widget.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/text_description.dart';
import '../widgets/video_view_widget.dart';
import 'comments_page.dart';

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
            backgroundImage: AssetImage('assets/nano.jpeg'),
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
        ):ListView(
          physics: BouncingScrollPhysics(),
          children:Provider.of<ArticleProvider>(context, listen: true).articleList.map((e) {

            // get index
            var index = Provider.of<ArticleProvider>(context, listen: true).articleList.indexOf(e);

            bool liked = false;
            bool reactionStatus = false;

            /*
            for(var like in e.likedUsers){
              if(like.id == Provider.of<UserProvider>(context,listen: false).user.id){
                setState(() {
                  liked = true;
                });
              }
            }

             */

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                                SizedBox(height: 12,),
                                Column(
                                  children: [
                                    Text(
                                      e.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: newsFontSize,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Column(
                                  children: [
                                    Text(
                                      e.createdAt.split('.').first.replaceAll("T", " "),
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.grey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                e.title.length < 50 ?Text(
                                  e.content,
                                  style: TextStyle(color: Colors.black54,
                                      fontSize: newsFontSize),
                                )
                                    :new DescriptionTextWidget(text: e.content),

                                /*
                          e.media.length == 0 ? Container(): ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl:e.media[0].fileType == "image" ? e.media[0].fileUrl : "https://i.ibb.co/1mTqZC3/security.jpg",
                              imageBuilder: (context, imageProvider) => Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),

                           */

                            /*
                                e.media.length == 0 ? Container(): e.media.length == 1 ? Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.circular(12)),
                                  //   color: Colors.grey,
                                  // ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child:e.media[0].fileType == "pdf" ? PdfWidget(fileUrl: e.media[0].fileUrl,) :  e.media[0].fileType == "video" ? InkWell(
                                      child: Image.asset("assets/images/Video-Icon-PNG-File.png"),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoViewWidget(videoName: e.media[0].fileName,videoUrl: e.media[0].fileUrl,)));
                                      },
                                    ) : InkWell(
                                      child: CachedNetworkImage(
                                        imageUrl: e.media[0].fileUrl,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              // colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewWidget(fileUrl:e.media[0].fileUrl)));
                                      },
                                    ),
                                  ),
                                  // Expanded(
                                  //     child: Text(caseFileList[index].CaseFileName)),
                                ) :
                                StaggeredGridView.countBuilder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 8,
                                    crossAxisCount: 2,
                                    itemCount: e.media.length,
                                    itemBuilder: (context, index) {


                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          color: Colors.grey,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          child:e.media[index].fileType == "pdf" ? PdfWidget(fileUrl: e.media[index].fileUrl,) :  e.media[index].fileType == "video" ? InkWell(
                                            child: Image.asset("assets/images/Video-Icon-PNG-File.png"),
                                            onTap: (){
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoViewWidget(videoName: e.media[index].fileName,videoUrl: e.media[index].fileUrl,)));
                                            },
                                          ) : InkWell(
                                            child: CachedNetworkImage(
                                              imageUrl: e.media[index].fileUrl,
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: MediaQuery.of(context).orientation == Orientation.portrait? 50 : MediaQuery.of(context).size.height * 0.4,
                                                width: MediaQuery.of(context).size.width * 0.3,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    // colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            onTap: (){
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewWidget(fileUrl:e.media[index].fileUrl)));
                                            },
                                          ),
                                        ),
                                        // Expanded(
                                        //     child: Text(caseFileList[index].CaseFileName)),
                                      );
                                    },
                                    staggeredTileBuilder: (index) {
                                      return StaggeredTile.count(1, index.isEven ? 1.4 : 1.9);
                                    }),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0, left: 28.0),
                                      child: InkWell(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 5.0),
                                                child:e.liked(userId: Provider.of<UserProvider>(context, listen:  false).user.id) == true ? Icon(Icons.thumb_up,color: Colors.blue,size: 20,): Image.asset(
                                                  'assets/images/like.png',
                                                  height: 20,
                                                ),
                                              ),
                                              Text(
                                                e.likedUsers.length.toString(),
                                                style: GoogleFonts.averageSans(
                                                    color: Colors.grey[700],
                                                    fontSize: 16,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          onTap: (){

                                            /*
                                            int userId = Provider.of<UserProvider>(context, listen:  false).user.id;
                                            if(e.liked(userId: userId)){

                                              Provider.of<LikesProvider>(context,listen: false).deleteLikes(Provider.of<UserProvider>(context,listen: false).user.accessToken,e.id.toString());
                                              print("trying to remove user id from liked $userId from news id ${e.id}");
                                              Provider.of<OutsideNewsProvider>(context, listen: false).removeLike(newsId: e.id, userId: userId);
                                            }
                                            else{
                                              Provider.of<LikesProvider>(context,listen: false).createLikes(Provider.of<UserProvider>(context,listen: false).user.accessToken,e.id.toString());
                                              Provider.of<OutsideNewsProvider>(context, listen: false).addLike(newsId: e.id, userId: userId);
                                            }

                                             */
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6, right: 22.0),
                                      child: InkWell(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Image.asset(
                                                'assets/images/comment.png',
                                                height: 20,
                                              ),
                                            ),
                                            Text(
                                              e.comments.length.toString(),
                                              style: GoogleFonts.averageSans(
                                                  color: Colors.grey[700],
                                                  fontSize: 16,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentsPage(newsIndex:index)));
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                             */

                              ]
                          ),
                        )
                    )
                ),
              ),
            );
          }).toList(),
        ),// we are going to create a list of text in this dynamic ii()
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: parseColor("#69001e"),
        child: Icon(FontAwesomeIcons.envelope,color: Colors.white,),
        onPressed: () {},
      ),
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
}