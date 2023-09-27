import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/pages/login_page.dart';

class MyAlertDialog{
  static ShowDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Sign In"),
          content: new Text("To do this operation, you need to sign in first."),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Yes"),
              onPressed: ()async{
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(loginStautus: false)));

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

}