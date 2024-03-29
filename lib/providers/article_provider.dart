
import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/article_model.dart';
import '../utils/api_services.dart';

class ArticleProvider extends ChangeNotifier{

  List<ArticleModel> articleList = [];

  int? current_page = 1;
  int? total_count;
  int? limit;
  int? offset;
  int? number_of_page;

  Future<bool> getArticle(String token,int pageNo) async{
    bool status = false;
    try{
      await ApiServices.getAllArticlePerPage(token,pageNo.toString()).then((value) {
        Map<String,dynamic> dataResponse = jsonDecode(value);
        print(dataResponse);
        List<dynamic> dlist = dataResponse['data'];
        print(dlist);

        current_page = dataResponse['pagination']['current_page'] ;
        total_count = dataResponse['pagination']['total_count'];
        limit = dataResponse['pagination']['limit'];
        offset = dataResponse['pagination']['offset'];
        number_of_page = dataResponse['pagination']['number_of_page'];

        if(pageNo == 1){
          articleList.clear();
        }


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

  hideArticle({required int articleId}){
    articleList.removeWhere((item) => item.id == articleId);
    print(articleId);
    notifyListeners();
  }

  blockUser({required int userId}){
    articleList.removeWhere((element) => element.user!.id == userId);
    print(userId);
    notifyListeners();
  }

  increseCommentCount({required int articleIndex}){
    articleList[articleIndex].commentCount += 1;

    print("before Increase");
    print(articleList[articleIndex].commentCount);

    print("after Increase");
    print(articleList[articleIndex].commentCount);
    notifyListeners();

  }

  voteReaction({required int articleIndex, required int voteType}){
    articleList[articleIndex].userVote = voteType;

    if(voteType == 0){
      articleList[articleIndex].downVote += 1;
    }
    else{
      articleList[articleIndex].upVote += 1;
    }
    notifyListeners();

  }




}