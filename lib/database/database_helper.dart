import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/models/user_model.dart';

class DatabaseHelper {
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
    String dbPath = path.join(dataDirectory.path, AppConstants.databaseName);
    return await openDatabase(
      dbPath,
      version: AppConstants.dbVersion,
      onCreate: _onCreateTable,
      onUpgrade: _onUpgradeTable,
    );
  }

  _onCreateTable(Database db, int version) async {
    String sql = '''
    CREATE TABLE ${AppConstants.userTable} (
      $columnAge INTEGER NOT NULL,
      $columnId STRING PRIMARY KEY,
      $columnName STRING NOT NULL,
      $columnEmail STRING NOT NULL UNIQUE,
      $columnProfileImage STRING,
      $columnToken STRING
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
    try {
      Database db = await database;
      final data = {
        columnId: user.id,
        columnName: user.name,
        columnEmail: user.email,
        columnAge: user.age,
      };
      return await db.insert(
        AppConstants.userTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error inserting user: $e');
      return -1;
    }
  }

  Future<UserModel?> fetchUser() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        AppConstants.userTable,
      );
      if (result.isNotEmpty) {
        return UserModel.fromJson(result.first);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  Future<int> deleteUser() async {
    try {
      Database db = await database;
      return await db.delete(
        AppConstants.userTable,
      );
    } catch (e) {
      debugPrint('Error deleting user: $e');
      return -1;
    }
  }

  Future<int> updateUserAge(int newAge) async {
    try {
      Database db = await database;
      return await db.update(
        AppConstants.userTable,
        {columnAge: newAge},
      );
    } catch (e) {
      debugPrint('Error updating user age: $e');
      return -1;
    }
  }

  Future<void> insertUserToken(String token) async {
    try {
      Database db = await database;
      await db.update(
        AppConstants.userTable,
        {columnToken: token},
      );
    } catch (e) {
      debugPrint('Error inserting user token: $e');
    }
  }

  Future<String?> fetchUserToken() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        AppConstants.userTable,
        columns: [columnToken],
      );
      if (result.isNotEmpty) {
        return result.first[columnToken] as String?;
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user token: $e');
      return null;
    }
  }

  Future<int> deleteUserToken() async {
    try {
      Database db = await database;
      return await db.update(
        AppConstants.userTable,
        {columnToken: null},
      );
    } catch (e) {
      debugPrint('Error deleting user token: $e');
      return -1;
    }
  }

  Future<void> insertUserProfileImage(String profileImage) async {
    try {
      Database db = await database;
      await db.update(
        AppConstants.userTable,
        {columnProfileImage: profileImage},
      );
    } catch (e) {
      debugPrint('Error inserting user profile image: $e');
    }
  }

  Future<String?> fetchUserProfileImage() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        AppConstants.userTable,
        columns: [columnProfileImage],
      );
      if (result.isNotEmpty) {
        return result.first[columnProfileImage] as String?;
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user profile image: $e');
      return null;
    }
  }

  Future<int> deleteUserProfileImage() async {
    try {
      Database db = await database;
      return await db.update(
        AppConstants.userTable,
        {columnProfileImage: null},
      );
    } catch (e) {
      debugPrint('Error deleting user profile image: $e');
      return -1;
    }
  }

  Future<void> closeDatabase() async {
    Database db = await database;
    db.close();
  }
}
