
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SQFLiteDriver {
  
  static Database _database;

  static final SQFLiteDriver driver = SQFLiteDriver._();

  SQFLiteDriver._();

  Future<Database> get database async {

    if (_database != null) return _database;

    _database = await initDB();

    //deleteAll();

    return _database;

  }

  initDB() async {

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cyclingtrainerdb.db');

    _onCreate(Database db, int version) async {
      // Database is created, create the table
      await db.execute(
              'CREATE TABLE Devices ('
              ' id TEXT PRIMARY KEY, '
              ' name TEXT '
              ' type TEXT, '
              ' deviceClass TEXT '
              ')'
            );
    }

    _onUpgrade(Database db, int oldVersion, int newVersion) async {
      // Database version is updated, alter the table

    }

    _onOpen(Database db) async {

    }

    return await openDatabase(
      path,
      version: 1,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: onDatabaseDowngradeDelete,
    );

  }
  
}