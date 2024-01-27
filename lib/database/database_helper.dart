import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:task_tracker_flutter/models/user_model.dart';

class DatabaseHelper {
  static const _databaseName = "taskTracker.db";
  static const _dbVersion = 1;
  static const userTable = 'users';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnAge = 'age';
  static const columnCreatedAt = 'createdAt';
  static const columnUpdatedAt = 'updatedAt';
  static const columnProfileImage = 'profileImage';
  static const columnToken = 'token';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(dataDirectory.path, _databaseName);
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreateTable,
      onUpgrade: _onUpgradeTable,
    );
  }

  _onCreateTable(Database db, int version) async {
    String sql = '''
    CREATE TABLE $userTable (
      $columnAge INTEGER NOT NULL,
      $columnId STRING PRIMARY KEY,
      $columnName STRING NOT NULL,
      $columnEmail STRING NOT NULL UNIQUE,
      $columnProfileImage STRING NOT NULL,
      $columnToken STRING NOT NULL
    )
  ''';

    await db.execute(sql);
  }

  _onUpgradeTable(Database db, oldVersion, newVersion) {
    if (oldVersion > newVersion) {
      //
    }
  }

  Future<int> insertUser(UserModel user) async {
    Database db = await database;
    return await db.insert(
      userTable,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> fetchUser() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
    );
    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  Future<int> deleteUser() async {
    Database db = await database;
    return await db.delete(userTable);
  }

  Future<int> updateUserAge(int newAge) async {
    Database db = await database;
    return await db.update(
      userTable,
      {columnAge: newAge},
    );
  }

  Future<void> insertUserToken(String token) async {
    Database db = await database;
    await db.update(
      userTable,
      {columnToken: token},
    );
  }

  Future<String?> fetchUserToken() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
      columns: [columnToken],
    );
    if (result.isNotEmpty) {
      return result.first[columnToken] as String?;
    }
    return null;
  }

  Future<int> deleteUserToken() async {
    Database db = await database;
    return await db.update(
      userTable,
      {columnToken: null},
    );
  }

  Future<void> insertUserProfileImage(String profileImage) async {
    Database db = await database;
    await db.update(
      userTable,
      {columnProfileImage: profileImage},
    );
  }

  Future<String?> fetchUserProfileImage() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      userTable,
      columns: [columnProfileImage],
    );
    if (result.isNotEmpty) {
      return result.first[columnProfileImage] as String?;
    }
    return null;
  }

  Future<int> deleteUserProfileImage() async {
    Database db = await database;
    return await db.update(
      userTable,
      {columnProfileImage: null},
    );
  }

  Future<void> closeDatabase() async {
    Database db = await database;
    db.close();
  }
}
