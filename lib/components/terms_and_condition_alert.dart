
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shared_preference_provider.dart';
import '../view/widgets/terms_and_condition_widget.dart';

class TermsAndConditionDialogs{
  static Future<void> termsAndConditionDialog(BuildContext context, GlobalKey key) async{
    return showDialog<void>(context: context,barrierDismissible: false,builder: (BuildContext context){
      return new WillPopScope(
        child: CupertinoAlertDialog(
          title: new Text("End-User License Agreement (EULA)"),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: 300,
            child: SingleChildScrollView(
              child: TermsAndConditionWidget(),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Agree"),
              onPressed: ()async{
                await Provider.of<SharedPreferenceProvider>(context,listen:  false).saveTermsAndConditionAgreement();

                Navigator.pop(context);
              },
            )
          ],
        ),
        onWillPop: ()async => false,
      );
    });
  }

}