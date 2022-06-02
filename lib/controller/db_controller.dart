// import 'dart:io';
//
// import 'package:path/path.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/products.dart';
//
// class DBProvider {
//   static Database _database;
//   static final DBProvider db = DBProvider._();
//
//   DBProvider._();
//
//   Future<Database> get database async {
//     // If database exists, return database
//     if (_database != null) return _database;
//
//     // If database don't exists, create one
//     _database = await initDB();
//
//     return _database;
//   }
//
//   // Create the database and the Employee table
//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'sales_manager.db');
//
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//           await db.execute('CREATE TABLE Sales('
//               'id INTEGER PRIMARY KEY,'
//               'sold_at TEXT,'
//               'outlet_id TEXT,'
//               'total_cost TEXT,'
//               ')');
//         });
//   }
//   // Insert employee on database
//   createEmployee(Sales sales) async {
//     await deleteAllEmployees();
//     final db = await database;
//     final res = await db.insert('Employee', sales.toJson());
//     return res;
//   }
//   // Delete all employees
//   Future<int> deleteAllEmployees() async {
//     final db = await database;
//     final res = await db.rawDelete('DELETE FROM Sales');
//
//     return res;
//   }
//   Future<List<Sales>> getAllEmployees() async {
//     final db = await database;
//     final res = await db.rawQuery("SELECT * FROM Sales");
//
//     List<Sales> list =
//     res.isNotEmpty ? res.map((c) => Sales.fromJson(c)).toList() : [];
//
//     return list;
//   }
// }