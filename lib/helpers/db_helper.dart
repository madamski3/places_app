import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(
    String tableName,
    Map<String, dynamic> data,
  ) async {
    final dbPath = await sql.getDatabasesPath();
    // Need to point to specific db at the path (places.db here)
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image_path TEXT)');
      },
      version: 1,
    );
    await db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
