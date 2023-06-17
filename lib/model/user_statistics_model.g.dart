// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatisticsModel _$UserStatisticsModelFromJson(Map<String, dynamic> json) =>
    UserStatisticsModel(
      rank: json['rank'] as String? ?? 'rank',
      nextRank: json['next_rank'] as String? ?? 'next_rank',
      rankProgress: json['rank_progress'] as int? ?? 0,
      level: json['level'] as String? ?? 'level',
      nextLevel: json['level_rank'] as String? ?? 'level_rank',
      levelProgress: json['level_progress'] as int? ?? 0,
      questionTotal: json['question_total'] as int? ?? 0,
      questionPassed: json['question_passed'] as int? ?? 0,
      questionFailed: json['question_failed'] as int? ?? 0,
      coinTotal: json['coin_total'] as int? ?? 0,
      coinExchanged: json['coin_exchanged'] as int? ?? 0,
      coinCurrent: json['coin_current'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? 'created_at',
      updatedAt: json['updated_at'] as String? ?? 'updated_at',
    );

Map<String, dynamic> _$UserStatisticsModelToJson(
        UserStatisticsModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'next_rank': instance.nextRank,
      'rank_progress': instance.rankProgress,
      'level': instance.level,
      'level_rank': instance.nextLevel,
      'level_progress': instance.levelProgress,
      'question_total': instance.questionTotal,
      'question_passed': instance.questionPassed,
      'question_failed': instance.questionFailed,
      'coin_total': instance.coinTotal,
      'coin_exchanged': instance.coinExchanged,
      'coin_current': instance.coinCurrent,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
