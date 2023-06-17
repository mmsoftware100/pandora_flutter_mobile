
import 'package:flutter/material.dart';

class Dialogs{
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async{
    return showDialog<void>(context: context,barrierDismissible: false,builder: (BuildContext context){
      return new WillPopScope(
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.black54,
            children: [
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text("please wait...",style: TextStyle(color: Colors.blueAccent),)
                  ],
                ),
              )
            ],
          ),
          onWillPop: ()async => false,
      );
    });
  }
}