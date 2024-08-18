import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tizibane_local_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS jobs_feed (
        id INTEGER PRIMARY KEY,
        closed TEXT,
        company_logo_url TEXT,
        company_name TEXT,
        company_address TEXT,
        position TEXT
      )
    ''');

  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> insertUser(List<Map<String, dynamic>> users) async {
    final db = await database;
    Batch batch = db.batch();
    for (var user in users) {
      batch.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  Future<void> deleteUsers() async {
    final db = await database;
    await db.delete('users');
  }

  Future<void> insertJobFeed(Map<String, dynamic> job) async {
    final db = await database;
    await db.insert('jobs_feed', job, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getJobFeeds() async {
    final db = await database;
    return await db.query('jobs_feed');
  }

  Future<void> deleteJobFeeds() async {
    final db = await database;
    await db.delete('jobs_feed');
  }


}
