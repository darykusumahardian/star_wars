
import 'package:sqflite/sqflite.dart';
import 'package:star_wars/model/users.dart';

class PvUsers {  
  static final PvUsers instance = PvUsers._init();
  static Database? _database;
  PvUsers._init();

  Future<Database> get database async {
    if (_database != null) _database;
    _database = await _initDB('starwars.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = "${dbPath.toString()}, ${filePath.toString()}";

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    String idUserType = "TEXT PRIMARY KEY";
    String emailType = "TEXT";
    String nameType = "TEXT";

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        ${PvUserFields.id} $idUserType,
        ${PvUserFields.email} $emailType,
        ${PvUserFields.name} $nameType
      );
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Simpan data
  Future<Users> createData(Users users) async {
    final db = await instance.database;
    final id = await db.insert(tableName, users.toJson());

    return users.copy(id: id.toString());
  }

  // Tampilkan data berdasarkan id
  Future<Users?> readDataByID(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: PvUserFields.values,
      where: "${PvUserFields.id.toString()} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Users.fromJson(maps.first);
    }else {
      return null;
    }
  }

  // Tampilkan semua data
  Future<List<Users?>> readAllData() async {
    final db = await instance.database;
    
    final result = await db.query(tableName);

    return result.map((json) => Users.fromJson(json)).toList();
  }
}