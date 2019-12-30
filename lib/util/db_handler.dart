import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_sqflite/util/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  DatabaseHandler._intenal();
  static final _instance = DatabaseHandler._intenal();

  factory DatabaseHandler() => _instance;

  static Database _database;

  Future<Database> get getDatabase async {
    if (_database == null) {
      _database = await initDb();
    }

    return _database;
  }

  initDb() async {
    Directory appDocDir;
    var path;

    appDocDir = await getApplicationDocumentsDirectory();
    if(appDocDir != null) {
      path = appDocDir.path + Constants.DATABASE_NAME;
    }
    // if the database already exist
    if(path != null && (FileSystemEntity.typeSync(path) == FileSystemEntityType.file))
      return await openDatabase(path);
    
    // If does not exist, copy from assets folder
    ByteData data = await rootBundle.load(join('data', Constants.DATABASE_NAME));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    File(path).writeAsBytes(bytes);
    return await openDatabase(path);
  }
}
