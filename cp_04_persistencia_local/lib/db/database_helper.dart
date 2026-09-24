import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('registros.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    return await openDatabase(
      fileName,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE registros (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT
)
''');
  }

  Future<int> insertRegistro(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('registros', row);
  }

  Future<List<Map<String, dynamic>>> getRegistros() async {
    final db = await instance.database;
    return await db.query('registros', orderBy: 'id DESC');
  }
}
