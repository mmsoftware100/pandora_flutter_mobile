// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'title',
      content: json['content'] as String? ?? 'content',
      createdAt: json['created_at'] as String? ?? 'created_at',
      updatedAt: json['updated_at'] as String? ?? 'updated_at',
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      upVote: json['up_vote'] as int? ?? 0,
      downVote: json['down_vote'] as int? ?? 0,
      commentCount: json['comment_count'] as int? ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
<<<<<<< HEAD
      userVote: json['user_vote'] as int? ?? -1,
=======
      userVote: json['user_vote'] as int? ?? 0,
>>>>>>> 23b96988d4a163a71c9d84e97b52cb790c7560b1
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user': instance.user?.toJson(),
      'up_vote': instance.upVote,
      'down_vote': instance.downVote,
      'comment_count': instance.commentCount,
      'user_vote': instance.userVote,
      'comments': instance.comments.map((e) => e?.toJson()).toList(),
      'user_vote': instance.userVote,
    };
