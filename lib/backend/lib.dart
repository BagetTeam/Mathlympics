import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class Backend {
  final User? user;

  Backend.init() : user = FirebaseAuth.instance.currentUser;
}
