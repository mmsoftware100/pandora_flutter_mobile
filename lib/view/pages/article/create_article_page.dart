import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/loader.dart';
import '../../../providers/article_provider.dart';
import '../../../providers/user_provider.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({Key? key}) : super(key: key);

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController contentController = TextEditingController();

  void _showToast(BuildContext context,String result) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(result),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    contentController.addListener((){
      //here you have the changes of your textfield
      // print("value: ${contentController.text}");
      //use setState to rebuild the widget
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                    child: Icon(Icons.arrow_back),
                onTap: (){
                     Navigator.pop(context);
                },
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('Create Post'),
                Spacer(),
                contentController.text.isNotEmpty ? ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: ()async {

                    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                    bool status = await Provider.of<ArticleProvider>(context, listen: false).createAritcle(accessToken!, "Test Page Title", contentController.text);
                    if(status == true){
                      _showToast(context,"Post created");
                      int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
                      await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,currentPage!);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Post'),
                ):
                    Container()

              ],
            ),
            Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),

             */
            /*
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/4/44/Facebook_Logo.png'),
              title: Text("Username Here"),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey),
                        onPressed: () {},
                        icon: Icon(Icons.group),
                        label: Row(
                          children: [
                            Text('Friends'),
                            Expanded(
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey),
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Row(
                          children: [
                            Text('Album'),
                            Expanded(
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

             */

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                  margin: const EdgeInsets.all(10.0),
                  /*child: CircleAvatar(
        backgroundImage: NetworkImage(this.avatar),
      ),*/
                  child:CachedNetworkImage(
                    imageUrl: Provider.of<UserProvider>(context,listen: true).user.photoUrl != "photo_url" ? Provider.of<UserProvider>(context,listen: true).user.photoUrl : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg",
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
              title: Text(Provider.of<UserProvider>(context,listen: true).user.name),
              /*
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey),
                        onPressed: () {},
                        icon: Icon(Icons.group),
                        label: Row(
                          children: [
                            Text('Friends'),
                            Expanded(
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey),
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Row(
                          children: [
                            Text('Album'),
                            Expanded(
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

               */
            ),
            const SizedBox(
              height: 10,
            ),


            TextFormField(
              maxLines: 5,
              controller: contentController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'What\'s on your Mind?',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: const Size.fromHeight(50)),
              onPressed: ()async {

                // show loading indicator
                Dialogs.showLoadingDialog(context, _keyLoader);


                String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                bool status = await Provider.of<ArticleProvider>(context, listen: false).createAritcle(accessToken!, "Test Page Title", contentController.text);


                if(status == true){
                  _showToast(context,"Post created");
                  int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
                  await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,currentPage!);
                  Navigator.pop(context);
                }
                else{
                  Navigator.pop(context);
                }
                // hide loading indicator
                Navigator.pop(context);
              },
              child: Text('Post'),
            )
          ],
        ),
      ),
    );
  }
}
