import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'urls.dart';

class ApiServices{

  static Future<dynamic> registration(body)async{
    print(body);
    http.Response response = await http.post(Uri.parse(URLs.registration_url),body: body);
    print(response.body);
    return response.body;
  }

  static Future<dynamic> login(body)async{
    print(body);
    http.Response response = await http.post(Uri.parse(URLs.login_url),body: body);
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getAllArticle(token)async{
    // print(token);
    http.Response response = await http.get(Uri.parse(URLs.article_url),

        headers: {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }


    );
    print(response.body);
    return response.body;
  }

  static Future<dynamic> createArticle(token,body)async{
    print(token);
    http.Response response = await http.post(Uri.parse(URLs.article_url),headers: {
      'Authorization': 'Bearer $token',
    },
    body:body);
    print("ApiServices createArticle");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> updateArticle(token,body,id)async{
    print(token);
    http.Response response = await http.put(Uri.parse(URLs.article_url+"/"+id.toString()),headers: {
      'Authorization': 'Bearer $token',
    },
        body:body);
    print("ApiServices updateArticle");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getComment(token,articelId)async{
    http.Response response = await http.get(Uri.parse(URLs.comments_url+"?article_id="+articelId.toString()),
      headers: {
      'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response.body;
  }

  static Future<dynamic> createComment(token,body)async{
    http.Response response = await http.post(Uri.parse(URLs.comments_url),headers: {
      'Authorization': 'Bearer $token',
    },
        body:body);
    print("ApiServices createComment");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> createVote(token,body)async{
    http.Response response = await http.post(Uri.parse(URLs.votes_url),headers: {
      'Authorization': 'Bearer $token',
    },
        body:body);
    print("ApiServices createVote");
    print(response.body);
    return response.body;
  }



  static Future<dynamic> getSpecialEventsSelectByClientId(token)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.events_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getSpecialEventsSelectByClientId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getSpecialEventsSelectByProjectId(token,projectId)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.events_url+"/project/"+projectId),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getSpecialEventsSelectByProjectId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getAssessmentsSelectByClientId(token)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.assessments_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getAssessmentsSelectByClientId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getAssessmentsSelectByProjectId(token,projectId)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.assessments_url+"/project/"+projectId),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getAssessmentsSelectByProjectId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getCctvNewsSelectByClientId(token)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.cctv_news_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getCctvNewsSelectByClientId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getCctvNewsSelectByProjectId(token,projectId)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.cctv_news_url+"/project/"+projectId),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getCctvNewsSelectByProjectId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getSuggestionsSelectByClientId(token)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.suggestion_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getSuggestionsSelectByClientId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getSuggestionsSelectByProjectId(token,projectId)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.suggestion_url+"/project/"+projectId),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getSuggestionsSelectByProjectId");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> getMyChatGroup(token)async{
    print(token);
    http.Response response = await http.get(Uri.parse(URLs.my_chat_group_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("ApiServices getMyChatGroup");
    print(response.body);
    return response.body;
  }

  /*
  static Future<dynamic> sendMessage(token,body)async{

    print(token);
    http.Response response = await http.post(Uri.parse(URLs.send_message_url),headers: {
      'Authorization': 'Bearer $token',
    },
        body: body);
    print("ApiServices sendMessage");
    print(response.body);
    return response.body;

  }

   */

  static Future<dynamic> sendMessage(token,chat_group_user_id,content,File? media)async{



    var request =  http.MultipartRequest(
        'POST', Uri.parse(URLs.send_message_url)

      );
      request.headers['Authorization'] ='Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['chat_group_user_id'] = chat_group_user_id;
      request.fields['content'] = content;

      print("file name is ");
      print(media?.path.split("/").last);
      String fileExtension = media?.path.split("/").last.split(".").last ?? "";
      MediaType mediaType = MediaType("images", "jpg");
    if(fileExtension == "mp4"){
      mediaType = MediaType("video", "mp4");
    }
    if(fileExtension == "pdf"){
      mediaType = MediaType("application", "pdf");
    }
      media != null ? request.files.add(

      await http.MultipartFile.fromPath('media',media.path, filename : media.path.split("/").last, contentType: mediaType)

        /*
          await http.MultipartFile(
              'media',
              File(media.path).readAsBytes().asStream(),
              File(media.path).lengthSync(),
              filename: media.path.split("/").last
          )

         */
        ):null;
var response = await request.send();
    print(response.stream);
    print(response.statusCode);
    final res = await http.Response.fromStream(response);
      print(res.body);

    /*
    print("Image Path is "+media!.path);

    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(URLs.send_message_url));
    request.fields.addAll({
      'chat_group_user_id': chat_group_user_id,
      'content': content
    });
    request.files.add(await http.MultipartFile.fromPath('media', media!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

     */


  }


  static Future<dynamic> createLikes(token,body)async{
    print(token);
    http.Response response = await http.post(Uri.parse(URLs.likes_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body:body);
    print("ApiServices createLikes");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> deleteLikes(token,body)async{
    print(token);
    http.Response response = await http.delete(Uri.parse(URLs.likes_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
        body:body);
    print("ApiServices deleteLikes");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> createComments(token,body)async{
    print(body);

    http.Response response = await http.post(Uri.parse(URLs.comments_url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
        body:body);
    print("ApiServices createComments");
    print(response.body);
    return response.body;
  }

  static Future<dynamic> deleteComments(token,commentID)async{
    print(token);
    http.Response response = await http.delete(Uri.parse(URLs.comments_url+"/"+commentID),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    );
    print("ApiServices deleteComments");
    print(response.body);
    return response.body;
  }
}