import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    // Need to point to specific db at the path (places.db here)
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image_path TEXT, latitude REAL, longitude REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.database();
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
