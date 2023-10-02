import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/loader.dart';
import '../../../providers/article_provider.dart';
import '../../../providers/user_provider.dart';

class UpdateArticlePage extends StatefulWidget {
  int articleId;
  String content;
  UpdateArticlePage({Key? key,required this.articleId,required this.content}) : super(key: key);

  @override
  State<UpdateArticlePage> createState() => _UpdateArticlePageState();
}

class _UpdateArticlePageState extends State<UpdateArticlePage> {

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

    contentController.text = widget.content;

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
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                Text('Update Post'),
                Spacer(),
                contentController.text.isNotEmpty ? ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: ()async {

                    // show loading indicator
                    Dialogs.showLoadingDialog(context, _keyLoader);

                    String accessToken = Provider.of<UserProvider>(context,listen: false).user.accessToken;
                    bool status = await Provider.of<ArticleProvider>(context, listen: false).updateAritcle(accessToken!, "Test Page Title", contentController.text,widget.articleId);

                    // hide loading indicator
                    Navigator.pop(context);

                    if(status == true){
                      _showToast(context,"Post updated");
                      int? currentPage = Provider.of<ArticleProvider>(context, listen: false).current_page;
                      await Provider.of<ArticleProvider>(context, listen: false).getArticle(accessToken,currentPage!);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update'),
                ):
                Container()

              ],
            ),
            Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 20,
            ),

             */
            TextFormField(
              maxLines: 10,
              controller: contentController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'What\'s on your Mind?',
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
