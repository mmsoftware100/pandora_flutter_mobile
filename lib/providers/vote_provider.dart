import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/api_services.dart';

class VoteProvider extends ChangeNotifier{

  Future<bool> createVote(String token,String articleId,String voteType)async{

    //0 for down vote and 1 for up vote

    bool status = false;

    var map = new Map<String, dynamic>();
    map['article_id'] = articleId;
    map['vote_type'] = voteType;

    try{
      await ApiServices.createVote(token,map).then((value) {
        Map<String,dynamic> datarespnse = jsonDecode(value);
        print(datarespnse);

        status = true;
      });
    }
    catch(exp){
      print(exp);
      print("create vote exp ->"+exp.toString());
      status = false;

    }
    return status;
  }
}