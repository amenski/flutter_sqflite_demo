
import 'package:flutter_sqflite/models/user.dart';
import 'package:flutter_sqflite/util/constants.dart';
import 'package:flutter_sqflite/util/db_handler.dart';

class LoginService {
 DatabaseHandler dbHandler = DatabaseHandler(); // factory instantiated singleton
 
  Future<int> saveUser(User user) async {
    var db = await dbHandler.getDatabase;
    return await db.insert("User", new Map.from(Constants.initialUserDetails));
  }
 
  Future<int> deleteUser(User user) async {
    var db = await dbHandler.getDatabase;
    return await db.delete("User");
  }
 
  Future<User> login(String user, String password) async {
    var db = await dbHandler.getDatabase;
    var res = await db.query('User', 
                          distinct: true, 
                          where: 'userName' + '=?' + 'password' + '=?',
                          whereArgs: [user, password]);//rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    
    if (res.length > 0) {
      return new User(userName: null, password: null).fromMap(res.first);
    }
 
    return null;
  }
 
  Future<List<User>> getAllUser() async {
    var dbClient = await dbHandler.getDatabase;
    var res = await dbClient.query("user");
    
    List<User> list = res.isNotEmpty 
            ? res.map((c) 
            => User(userName: null, password: null).fromMap(c)).toList() 
            : null;
 
    return list;
  }
}