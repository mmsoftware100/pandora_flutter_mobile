import 'package:json_annotation/json_annotation.dart';
import 'package:pandora_flutter_mobile/model/user_model.dart';

import '../domain/entities/user.dart';
part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)

class CommentModel {
  CommentModel({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.content,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id' ,defaultValue: 0)
  int id;

  @JsonKey(name: 'article_id' ,defaultValue: 0)
  int articleId;

  @JsonKey(name: 'user_id' ,defaultValue: 0)
  int userId;

  @JsonKey(name: 'content' ,defaultValue: 'content')
  String content;

  @JsonKey(name: 'user' ,defaultValue: null)
  UserModel? user;

  @JsonKey(name: 'created_at' ,defaultValue: "created_at")
  String createdAt;

  @JsonKey(name: 'updated_at' ,defaultValue: "updated_at")
  String updatedAt;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

