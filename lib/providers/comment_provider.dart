import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/model/comment_model.dart';

import '../utils/api_services.dart';

class CommentProvider extends ChangeNotifier{

  List<CommentModel> commentList = [];

  Future<bool> createComment(String token,String articleId,String content)async{
    bool status = false;

    var map = new Map<String, dynamic>();
    map['article_id'] = articleId;
    map['content'] = content;

    try{
      await ApiServices.createComment(token,map).then((value) {
        Map<String,dynamic> datarespnse = jsonDecode(value);
        print(datarespnse);

        status = true;
      });
    }
    catch(exp){
      print(exp);
      print("create comment exp ->"+exp.toString());
      status = false;

    }
    return status;
  }


  Future<bool> getComment(String token,int articleId) async{
    bool status = false;
    try{
      await ApiServices.getComment(token,articleId).then((value) {
        Map<String,dynamic> dataResponse = jsonDecode(value);
        print(dataResponse);

        commentList.clear();

        List<dynamic> dlist = dataResponse['data'];
        print(dlist);

        for(int i = 0; i < dlist.length; i++){
          try{
            commentList.add(CommentModel.fromJson(dlist[i]));
          }
          catch(exp){
            print(exp);
            print("comment internal exp");
          }
        }
        print("Hey comment");
        print(commentList);

      });
      notifyListeners();
      status = true;
    }catch (Exc) {
      print(Exc);
      status = false;
    }
    return status;
  }

  void addComment({required int articleId, required int userId,required String comment,required user}){
    commentList.add(CommentModel(id: 0, articleId: articleId, userId: userId, content: comment, user: user, createdAt: DateTime.now().toString(), updatedAt: DateTime.now().toString(),));
    notifyListeners();
  }

}