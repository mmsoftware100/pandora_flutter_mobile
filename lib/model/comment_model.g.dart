// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int? ?? 0,
      articleId: json['article_id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      content: json['content'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String? ?? 'created_at',
      updatedAt: json['updated_at'] as String? ?? 'updated_at',
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'article_id': instance.articleId,
      'user_id': instance.userId,
      'content': instance.content,
      'user': instance.user?.toJson(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
