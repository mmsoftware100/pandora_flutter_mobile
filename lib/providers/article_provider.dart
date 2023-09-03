
import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/article_model.dart';
import '../utils/api_services.dart';

class ArticleProvider extends ChangeNotifier{

  List<ArticleModel> articleList = [];

  Future<bool> getArticle() async{
    bool status = false;
    try{
      await ApiServices.getAllArticle().then((value) {
        Map<String,dynamic> dataResponse = jsonDecode(value);
        print(dataResponse);
        List<dynamic> dlist = dataResponse['data'];
        print(dlist);

        articleList.clear();

        for(int i = 0; i < dlist.length; i++){
          try{
            articleList.add(ArticleModel.fromJson(dlist[i]));
          }
          catch(exp){
            print(exp);
            print("article internal exp");
          }
        }
        print("Hey article");
        print(articleList);

      });
      notifyListeners();
      status = true;
    }catch (Exc) {
      print(Exc);
      status = false;
    }
    return status;
  }

  Future<bool> createAritcle(String token,String title,String content)async{
    bool status = false;

    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['content'] = content;

    try{
      await ApiServices.createArticle(token,map).then((value) {
        Map<String,dynamic> datarespnse = jsonDecode(value);
        print(datarespnse);

        status = true;
      });
    }
    catch(exp){
      print(exp);
      print("create Article exp ->"+exp.toString());
      status = false;

    }
    return status;
  }

  Future<bool> updateAritcle(String token,String title,String content,int articleId)async{
    bool status = false;

    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['content'] = content;

    try{
      await ApiServices.updateArticle(token,map,articleId).then((value) {
        Map<String,dynamic> datarespnse = jsonDecode(value);
        print(datarespnse);

        status = true;
      });
    }
    catch(exp){
      print(exp);
      print("update Article exp ->"+exp.toString());
      status = false;

    }
    return status;
  }

}