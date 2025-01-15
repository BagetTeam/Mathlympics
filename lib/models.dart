import "package:supabase_flutter/supabase_flutter.dart";

SupabaseClient supabase = Supabase.instance.client;

class UserModel {
  String id;
  String createdAt;
  String displayName;
  int level;

  UserModel.from(Map<String, dynamic> data)
      : id = data["id"],
        createdAt = data["created_at"],
        displayName = data["display_name"],
        level = data["level"];
}

enum Mode { ten }

class TopScoreModel {
  String id;
  double times;
  Mode mode;

  TopScoreModel.from(Map<String, dynamic> data)
      : id = data["id"],
        times = data["times"],
        mode = Mode.ten;
}
