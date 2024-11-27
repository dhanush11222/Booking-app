import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final pathToDb = join(dbPath, path);

    return openDatabase(
      pathToDb,
      version: 1,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS users');
        await db.execute('DROP TABLE IF EXISTS user');
        await _createDB(db, newVersion);
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_logged_in INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<bool> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    try {
      await db.insert(
        'users',
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      print('Error inserting user: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await instance.database;
    return await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<void> checkTables() async {
    final db = await instance.database;
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    print("Tables in DB: $tables");
  }

  Future<bool> isLoggedIn() async {
    final db = await database;
    final result = await db.query('user', limit: 1);
    if (result.isNotEmpty) {
      return result.first['is_logged_in'] == 1;
    }
    return false;
  }

  Future<void> setLoginStatus(bool status) async {
    final db = await database;
    await db.delete('user'); // Ensure only one entry exists.
    await db.insert('user', {'is_logged_in': status ? 1 : 0});
  }
}
