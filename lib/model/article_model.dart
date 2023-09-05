
import 'package:json_annotation/json_annotation.dart';
import 'package:pandora_flutter_mobile/model/user_model.dart';

import '../domain/entities/user.dart';
import 'comment_model.dart';
part 'article_model.g.dart';

@JsonSerializable(explicitToJson: true)

class ArticleModel {
  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.upVote,
    required this.downVote,
    required this.commentCount,
    required this.comments,
    required this.userVote,
  });

  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(name: 'title' ,defaultValue: "title")
  String title;

  @JsonKey(name: 'content' ,defaultValue: "content")
  String content;

  @JsonKey(name: 'created_at' ,defaultValue: "created_at")
  String createdAt;

  @JsonKey(name: 'updated_at' ,defaultValue: "updated_at")
  String updatedAt;

  @JsonKey(name: 'user' ,defaultValue: null)
  UserModel? user;

  @JsonKey(name: 'up_vote' ,defaultValue: 0)
  int upVote;

  @JsonKey(name: 'down_vote' ,defaultValue: 0)
  int downVote;

  @JsonKey(name: 'comment_count' ,defaultValue: 0)
  int commentCount;

  @JsonKey(name: 'user_vote' ,defaultValue: -1)
  int userVote;

  @JsonKey(name: 'comments' ,defaultValue: [])
  List<CommentModel?> comments;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

