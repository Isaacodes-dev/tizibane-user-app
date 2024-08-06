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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS contacts (
        nrc TEXT PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        phone_number TEXT,
        user_email TEXT,
        company_id TEXT,
        position_id TEXT,
        role_id TEXT,
        created_at TEXT,
        updated_at TEXT,
        profile_picture TEXT,
        position_name TEXT,
        company_name TEXT,
        company_email TEXT,
        company_logo_url TEXT,
        company_phone TEXT,
        company_address TEXT,
        company_website TEXT,
        company_assigned_email TEXT,
        telephone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS job_statuses (
        job_listing_id TEXT PRIMARY KEY,
        status TEXT
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

  Future<void> insertContacts(List<Map<String, dynamic>> contacts) async {
    final db = await database;
    Batch batch = db.batch();
    for (var contact in contacts) {
      batch.insert('contacts', contact, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await database;
    return await db.query('contacts');
  }

  Future<void> deleteContacts() async {
    final db = await database;
    await db.delete('contacts');
  }

  Future<void> insertJobStatus(String jobListingId, String status) async {
    final db = await database;
    await db.insert(
      'job_statuses',
      {'job_listing_id': jobListingId, 'status': status},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getJobStatus(String jobListingId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'job_statuses',
      where: 'job_listing_id = ?',
      whereArgs: [jobListingId],
    );

    if (maps.isNotEmpty) {
      return maps.first['status'];
    } else {
      return null;
    }
  }

  Future<void> deleteJobStatuses() async {
    final db = await database;
    await db.delete('job_statuses');
  }
}
