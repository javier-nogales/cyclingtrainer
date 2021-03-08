
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SQFLiteDriver {
  
  static Database _database;

  static final SQFLiteDriver driver = SQFLiteDriver._();

  SQFLiteDriver._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<void> initDriver() async {
    if (_database == null) {
      _database = await _initDB();
    }
  }

  Future<Database> _initDB() async {

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cyclingtrainerdb.db');

    _onCreate(Database db, int version) async {
      // Database is created, create the table
      await db.execute(
              'CREATE TABLE devices (id TEXT PRIMARY KEY, name TEXT, type TEXT, deviceClass TEXT)'
            );
    }

    _onUpgrade(Database db, int oldVersion, int newVersion) async {
      // Database version is updated, alter the table
      db.execute('DROP TABLE IF EXISTS Devices');
      db.execute('DROP TABLE IF EXISTS devices');
      db.execute('CREATE TABLE devices (id TEXT PRIMARY KEY, name TEXT, type TEXT, deviceClass TEXT)');
    }

    _onOpen(Database db) async {

    }

    return await openDatabase(
      path,
      version: 3,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: onDatabaseDowngradeDelete,
    );

  }

  Future<int> deleteAll() async {
    final db = await database;
    final result = await db.delete('devices');
    return result;
  }
  
}