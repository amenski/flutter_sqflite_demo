import 'package:flutter/foundation.dart';

class User {
  int id;
  String userName;
  String password;

  User({this.id, @required this.userName, @required this.password});

  String get getUsername => userName;

  fromMap(Map<String, dynamic> user) {
    return new User(id: user['id'], userName: user['userName'],password: user['password']);
  }
}