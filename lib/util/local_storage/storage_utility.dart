import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/data/response_models/task_model.dart';

class CLocalStorage {
  CLocalStorage._();
  static final appDataBase = CLocalStorage._();

  Database? db;

  static const DATABASE_NAME = 'task.db';
  static const TABLE_NAME = 'task';
  static const TASK_ID = 'task_id';
  static const USER_ID = 'user_id';
  static const TASK_NAME = 'task_name';
  static const TASK_DESCRIPTION = 'task_description';
  static const TASK_CURRENT_STATUS = 'current_status';
  static const TASK_DUE_DATE = 'task_due_date';

  /// Get database instance
  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    } else {
      db = await initDb();
      return db!;
    }
  }

  /// Initialize database
  Future<Database> initDb() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var actualPath = join(rootPath.path, DATABASE_NAME);
    return await openDatabase(actualPath, version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $TABLE_NAME ( $TASK_ID INTEGER PRIMARY KEY,$USER_ID INTEGER NOT NULL, $TASK_NAME TEXT NOT NULL, $TASK_DESCRIPTION TEXT NOT NULL, $TASK_CURRENT_STATUS TEXT NOT NULL, $TASK_DUE_DATE TEXT NOT NULL)");
    });
  }

  /// Add a new task to the database
  Future<int> addTask(dynamic model) async {
    final db = await getDb();
    int id = await db.insert(
      TABLE_NAME,
      model.toDoc(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  /// Fetch all tasks from the database
  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await getDb();
    return await db.query(TABLE_NAME);
  }

  Future<List<Map<String, dynamic>>> fetchTasksByUserId(int userId) async {
    final db = await getDb();
    return await db.query(
      TABLE_NAME,
      where: '$USER_ID = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateTaskStatus(TaskModel model) async {
    final db = await getDb();
    return await db.update(
      TABLE_NAME,
      model.toDoc(),
      where: '$USER_ID = ? AND $TASK_ID = ?',
      whereArgs: [model.userId, model.taskId],
    );
  }
}
