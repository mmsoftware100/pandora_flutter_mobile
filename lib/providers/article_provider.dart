
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


}