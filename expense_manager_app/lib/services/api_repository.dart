import 'package:expense_manager_app/models/category.dart';
import 'package:expense_manager_app/models/enums/record_type_enum.dart';
import 'package:expense_manager_app/models/record.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class ApiRepository {
  Future<Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, "records.db"),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE category("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title TEXT,"
            "icon INTEGER,"
            "iconColor INTEGER,"
            "recordType TEXT"
            ")");

        //add expense category
        await db.insert("category", foodCategory.toJson());
        await db.insert("category", learningCategory.toJson());
        await db.insert("category", shoppingCategory.toJson());
        await db.insert("category", leisureCategory.toJson());
        await db.insert("category", travelCategory.toJson());
        await db.insert("category", workCategory.toJson());

        //add income category
        await db.insert("category", salaryCategory.toJson());
        await db.insert("category", bonusCategory.toJson());
        await db.insert("category", investmentCategory.toJson());

        await db.execute("CREATE TABLE records("
            "id TEXT PRIMARY KEY,"
            "title TEXT,"
            "amount INTEGER,"
            "date DATETIME,"
            "recordType TEXT,"
            "note TEXT,"
            "categoryId INTEGER,"
            "FOREIGN KEY (categoryId) REFERENCES category(id)"
            ")");
      },
      version: 1,
    );
    return db;
  }

  Future<bool> addRecord(
    String title,
    int amount,
    DateTime date,
    RecordType recordType,
    String note,
    int recordCategoryId,
  ) async {
    try {
      final newRecord = RecordData(
        title: title,
        amount: amount,
        date: date,
        recordType: recordType,
        note: note,
        recordCategoryId: recordCategoryId,
      );

      final db = await getDatabase();

      await db.insert("records", newRecord.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<RecordData>> loadRecords() async {
    final db = await getDatabase();
    final data = await db.query("records");
    final records = data
        .map(
          (row) => RecordData.fromJson(row),
        )
        .toList();
    return records;
  }

  Future<List<Category>> loadCategories() async {
    final db = await getDatabase();
    final data = await db.query("category");
    final categories = data
        .map(
          (row) => Category.fromJson(row),
        )
        .toList();

    return categories;
  }

  Future<int> deleteRecord(String id) async {
    final db = await getDatabase();
    return await db.delete("records", where: "id = ?", whereArgs: [id]);
  }

  Future<bool> updateRecord(
    String id,
    String title,
    int amount,
    DateTime date,
    RecordType recordType,
    String note,
    int recordCategoryId,
  ) async {
    try {
      final updateRecord = RecordData(
        id: id,
        title: title,
        amount: amount,
        date: date,
        recordType: recordType,
        note: note,
        recordCategoryId: recordCategoryId,
      );

      final db = await getDatabase();

      await db.update(
        "records",
        {
          "id": updateRecord.id,
          "title": updateRecord.title,
          "amount": updateRecord.amount,
          "date": updateRecord.date.toString(),
          "recordType": updateRecord.recordType.name, //
          "note": updateRecord.note,
          "categoryId": updateRecord.recordCategoryId,
        },
        where: "id = ?",
        whereArgs: [id],
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
