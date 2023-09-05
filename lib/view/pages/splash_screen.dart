import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../../data/constant/const.dart';
import '../../providers/article_provider.dart';
import '../../providers/user_provider.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;


  bool getArticleStatus = false;
/*
  getArticle()async{
    await Provider.of<ArticleProvider>(context, listen: false).getArticle();
  }

   */

  _SplashScreenState(){

    new Timer(const Duration(milliseconds: 2000), () async {


      getArticleStatus = await Provider.of<ArticleProvider>(context, listen: false).getArticle(1);
      if(getArticleStatus == true){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      }
      /*
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      });

       */


    });

    new Timer(
      Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: ClipOval(
                // child: Icon(Icons.android_outlined, size: 128,), //put your logo here
                // child: AssetImage("assets/pandora_box.jpg"),
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  child: Image.asset(
                    'assets/pandora_box.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: Offset(5.0, 3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}