import "package:supabase_flutter/supabase_flutter.dart";

SupabaseClient supabase = Supabase.instance.client;

class UserModel {
  UserModel(
      {required this.id,
      required this.createdAt,
      required this.displayName,
      required this.level});

  String id;
  String createdAt;
  String displayName;
  int level;

  factory UserModel.from(Map<String, dynamic> data) => UserModel(
        id: data["id"],
        createdAt: data["created_at"],
        displayName: data["display_name"],
        level: data["level"],
      );
}
