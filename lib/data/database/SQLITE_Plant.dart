import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PlantDatabase {
  static final PlantDatabase instance = PlantDatabase._init();

  static Database? _database;

  PlantDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE plants (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      hasPlant INTEGER NOT NULL
    )
    ''');
    print('Tabela plants criada.');
  }
}
