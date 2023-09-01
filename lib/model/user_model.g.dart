// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int? ?? 0,
      uid: json['uid'] as String? ?? 'uid',
      name: json['name'] as String? ?? 'name',
      phone: json['phone'] as String? ?? 'phone',
      city: json['city'] as String? ?? 'city',
      age: json['age'] as String? ?? 'age',
      gender: json['gender'] as String? ?? 'gender',
      photoUrl: json['photo_url'] as String? ?? 'photo_url',
      email: json['email'] as String? ?? 'email',
      emailVerifiedAt: json['emailVerifiedAt'] as String? ?? 'emailVerifiedAt',
      roleId: json['role_id'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? 'created_at',
      updatedAt: json['updated_at'] as String? ?? 'updated_at',
      accessToken: json['access_token'] as String? ?? 'access_token',
      userStatistics: (json['user_statistics'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : UserStatisticsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'age': instance.age,
      'gender': instance.gender,
      'photo_url': instance.photoUrl,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'role_id': instance.roleId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'access_token': instance.accessToken,
      'user_statistics':
          instance.userStatistics.map((e) => e?.toJson()).toList(),
    };
