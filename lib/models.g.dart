// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      displayName: json['displayName'] as String,
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'displayName': instance.displayName,
      'level': instance.level,
    };

TopScoresModel _$TopScoresModelFromJson(Map<String, dynamic> json) =>
    TopScoresModel(
      id: (json['id'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      uid: json['uid'] as String,
      mode: $enumDecode(_$ModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$TopScoresModelToJson(TopScoresModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'uid': instance.uid,
      'mode': _$ModeEnumMap[instance.mode]!,
    };

const _$ModeEnumMap = {
  Mode.cal20: 'cal20',
  Mode.cal50: 'cal50',
  Mode.time30: 'time30',
  Mode.time60: 'time60',
  Mode.integ10: 'integ10',
  Mode.integ30: 'integ30',
  Mode.summ: 'summ',
};

LeaderboardModel _$LeaderboardModelFromJson(Map<String, dynamic> json) =>
    LeaderboardModel(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String,
      topScore: (json['topScore'] as num).toDouble(),
      mode: $enumDecode(_$ModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$LeaderboardModelToJson(LeaderboardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'topScore': instance.topScore,
      'mode': _$ModeEnumMap[instance.mode]!,
    };
