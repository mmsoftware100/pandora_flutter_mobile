import 'package:json_annotation/json_annotation.dart';
import 'package:myan_quiz/domain/entities/user_statistics.dart';

import '../../domain/entities/user.dart';


part 'user_statistics_model.g.dart';
@JsonSerializable(explicitToJson: true)
class UserStatisticsModel{

  @JsonKey(name: 'rank' ,defaultValue: "rank")
  String rank;
  @JsonKey(name: 'next_rank' ,defaultValue: "next_rank")
  String nextRank;
  @JsonKey(name: 'rank_progress' ,defaultValue: 0)
  int rankProgress;

  @JsonKey(name: 'level' ,defaultValue: "level")
  String level;
  @JsonKey(name: 'level_rank' ,defaultValue: "level_rank")
  String nextLevel;
  @JsonKey(name: 'level_progress' ,defaultValue: 0)
  int levelProgress;


  @JsonKey(name: 'question_total' ,defaultValue: 0)
  int questionTotal;

  @JsonKey(name: 'question_passed' ,defaultValue: 0)
  int questionPassed;

  @JsonKey(name: 'question_failed' ,defaultValue: 0)
  int questionFailed;

  @JsonKey(name: 'coin_total' ,defaultValue: 0)
  int coinTotal;

  @JsonKey(name: 'coin_exchanged' ,defaultValue: 0)
  int coinExchanged;

  @JsonKey(name: 'coin_current' ,defaultValue: 0)
  int coinCurrent;

  @JsonKey(name: 'created_at' ,defaultValue: "created_at")
  String createdAt;

  @JsonKey(name: 'updated_at' ,defaultValue: "updated_at")
  String updatedAt;


  UserStatisticsModel({
    required this.rank,
    required this.nextRank,
    required this.rankProgress,

    required this.level,
    required this.nextLevel,
    required this.levelProgress,

    required this.questionTotal,
    required this.questionPassed,
    required this.questionFailed,

    required this.coinTotal,
    required this.coinExchanged,
    required this.coinCurrent,

    required this.createdAt,
    required this.updatedAt,
  });

  factory UserStatisticsModel.fromJson(Map<String, dynamic> json) {
    return _$UserStatisticsModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserStatisticsModelToJson(this);

  UserStatistics toEntity(){
    return UserStatistics(rank: rank, nextRank: nextRank, rankProgress: rankProgress, level: level, nextLevel: nextLevel, levelProgress: levelProgress, questionTotal: questionTotal, questionPassed: questionPassed, questionFailed: questionFailed, coinTotal: coinTotal, coinExchanged: coinExchanged, coinCurrent: coinCurrent, createdAt: createdAt, updatedAt: updatedAt);
  }
}


