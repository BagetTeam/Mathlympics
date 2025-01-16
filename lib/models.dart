import "package:supabase_flutter/supabase_flutter.dart";
import "package:json_annotation/json_annotation.dart";

part "models.g.dart";

SupabaseClient supabase = Supabase.instance.client;

typedef Json = Map<String, dynamic>;

// define the model with the fields that exactly matches the column name
// define the constructor
// run 'dart run build_runner build' to build the models.g.dart file
// create toJson() and fromJson functions

@JsonSerializable()
class UserModel {
  String id, createdAt, displayName;
  int level;

  UserModel(
      {required this.id,
      required this.createdAt,
      required this.displayName,
      required this.level});

  Json toJson() => _$UserModelToJson(this);
  factory UserModel.fromJson(Json json) => _$UserModelFromJson(json);
}

@JsonEnum()
enum Mode { cal20, cal50, time30, time60, integ10, integ30, summ }

@JsonSerializable()
class TopScoresModel {
  int id;
  double score;
  String uid;
  Mode mode;

  TopScoresModel(
      {required this.id,
      required this.score,
      required this.uid,
      required this.mode});

  Json toJson() => _$TopScoresModelToJson(this);
  factory TopScoresModel.fromJson(Json json) => _$TopScoresModelFromJson(json);
}

@JsonSerializable()
class LeaderboardModel {
  int id;
  String uid;
  double topScore;
  Mode mode;

  LeaderboardModel(
      {required this.id,
      required this.uid,
      required this.topScore,
      required this.mode});

  Json toJson() => _$LeaderboardModelToJson(this);
  factory LeaderboardModel.fromJson(Json json) =>
      _$LeaderboardModelFromJson(json);
}
