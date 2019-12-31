
import 'package:flutter_sqflite/models/user.dart';
import 'package:flutter_sqflite/util/constants.dart';
import 'package:flutter_sqflite/util/db_handler.dart';

class LoginService {
 DatabaseHandler dbHandler = DatabaseHandler(); // factory instantiated singleton
 
  Future<User> login(String user, String password) async {
    var db = await dbHandler.getDatabase;
    var res = await db.query(Constants.USER_TABLE_NAME,  
                                where: 'user_name' + '=?' + ' and ' + 'password' + '=?',
                                whereArgs: [user, password]); // or use rawQuery(select * from user where user_name=$user and password="$password")
    
    if (res.isNotEmpty) {
      return new User(userName: null, password: null).fromMap(res.first);
    }
 
    return null;
  }
 
  Future<List<User>> getAllUser() async {
    var dbClient = await dbHandler.getDatabase;
    var res = await dbClient.query(Constants.USER_TABLE_NAME);
    
    List<User> list = res.isNotEmpty 
            ? res.map((c) 
            => User(userName: null, password: null).fromMap(c)).toList() 
            : null;
 
    return list;
  }
}