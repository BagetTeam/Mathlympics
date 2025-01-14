import "package:flutter/material.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class UserState extends InheritedWidget {
  const UserState({super.key, required super.child, required this.user});

  final User? user;

  @override
  bool updateShouldNotify(UserState oldWidget) {
    return user != oldWidget.user;
  }

  static UserState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<UserState>();

    assert(result != null, "No MyState found in context");

    return result!;
  }
}
