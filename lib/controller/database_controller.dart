// import 'package:mobitrack_dv_flutter/model/bank.dart';
// import 'package:mobitrack_dv_flutter/model/collections.dart';
// import 'package:mobitrack_dv_flutter/model/distributor.dart';
// import 'package:mobitrack_dv_flutter/model/outlet.dart';
// import 'package:mobitrack_dv_flutter/model/products.dart';
// //import 'package:mobitrack_dv_flutter/utils/constants.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:mobitrack_dv_flutter/model/location_model.dart';
//
// class DatabaseHelper {
//   static final _databaseName = "mobitrac_dv.db";
//   static final _databaseVersion = 1;
//
//   static final locationTable = 'location';
//   static final outletsTable = 'outlets';
//   static final collectionsTable = 'collections';
//   static final productsTable = 'products';
//   static final salesTable = 'sales';
//   static final bankTable = 'banks';
//   static final distributor = 'distributor';
//
//   // make this a singleton class
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   // only have a single app-wide reference to the database
//   static Database _database;
//   Future<Database> get instace async {
//     if (_database != null) return _database;
//     // lazily instantiate the db the first time it is accessed
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   // this opens the database (and creates it if it doesn't exist)
//   _initDatabase() async {
//     var path = await getDatabasesPath() + '/' + _databaseName;
//     return await openDatabase(path, onOpen: (db) {
//       _onCreate(db, _databaseVersion);
//     }, version: _databaseVersion, onCreate: _onCreate);
//   }
//
//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     //create user table
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $locationTable (
//               id TEXT,
//               latitude TEXT,
//               longitude TEXT,
//               date TEXT,
//               checkinout_id TEXT,
//               outlet_id TEXT
//               )
//           ''');
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $bankTable (
//               id INTEGER,
//               bank_name TEXT,
//               bank_code TEXT,
//               created_at TEXT,
//               updated_at TEXT
//               )
//           ''');
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $outletsTable (
//               id TEXT,
//               name TEXT,
//               owner_name TEXT,
//               contact TEXT,
//               type TEXT,
//               latitude TEXT,
//               longitude TEXT,
//               address_id TEXT,
//               street TEXT,
//               image TEXT,
//               distributor_id TEXT,
//               zone TEXT,
//               town TEXT,
//               route TEXT,
//               channel TEXT,
//               category TEXT,
//               frequency TEXT,
//               synced TEXT
//               )
//           ''');
//
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $collectionsTable (
//               id TEXT PRIMARY KEY,
//               distributor_id TEXT,
//               mode TEXT,
//               bank_name TEXT,
//               cheque_no TEXT,
//               cheque_photo TEXT,
//               amount TEXT,
//               account_of TEXT,
//               remarks TEXT,
//               device_time TEXT,
//               created_at TEXT,
//               updated_at TEXT,
//               synced INTEGER
//               )
//           ''');
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $productsTable (
//               id INTEGER PRIMARY KEY,
//               name TEXT,
//               unit TEXT,
//               value INTEGER,
//               created_at TEXT,
//               updated_at TEXT,
//               batches TEXT
//               )
//           ''');
//
//     await db.execute('''
//           CREATE TABLE IF NOT EXISTS $salesTable (
//               id INTEGER PRIMARY KEY,
//               distributor_id TEXT,
//               sold_at TEXT,
//               remark TEXT,
//               orders TEXT,
//               outlet_latitude TEXT,
//               outlet_longitude TEXT,
//               outlet_id TEXT
//               )
//           ''');
//
//   }
//   // query()async{
//   //   Database db = await instance.instace;
//   //   //return await db?.query(table ,groupBy: route);
//   //     //return await db?.rawQuery('SELECT name from outlets Group by route having count(route) >1');
//   //   //Constants.selectedOutlets.route.toString() = String ASd;
//   // //  String asd = Constants.selectedOutlets.route.toString();
//   //   return await db?.rawQuery('SELECT * FROM outlets');
//   // }
//
//   Future<LocationModel> insertLocationData(
//       LocationModel locationModel, bool inOutlet) async {
//     Database db = await instance.instace;
//     await db.insert(locationTable, locationModel.toJson(inOutlet));
//     // print('inserted location data');
//     return locationModel;
//   }
//
//   Future<List<LocationModel>> getAllLocationData() async {
//     Database db = await instance.instace;
//     List<LocationModel> location = [];
//     var res = await db.query(locationTable);
//     res.forEach((element) {
//       location.add(LocationModel.fromJson(element));
//     });
//     return location;
//   }
//
//   Future<int> removeLocationData(String id) async {
//     Database db = await instance.instace;
//     return await db.delete(locationTable, where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<int> removeAllLocationData() async {
//     Database db = await instance.instace;
//     return await db.delete(locationTable);
//   }
//
//   Future<bool> insertdistributor(Distributor o) async {
//     Database db = await instance.instace;
//     try {
//       var res = await db.insert(distributor, o.toJson());
//       return res != 0;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   List<Distributor> distributors =[];
//   Future<List<Distributor>> getAlldistributorData() async {
//     Database db = await instance.instace;
//     var res = await db.query(distributor);
//     res.forEach((element) {
//       distributors.add(Distributor.fromJson(element));
//     });
//     return distributors;
//   }
//   Future<bool> deletedistributor(Distributor o) async {
//     Database db = await instance.instace;
//     var res = await db.delete(distributor, where: 'id = ?', whereArgs: [o.id]);
//     return res != 0;
//   }
//
//
//
//
//
//
//   //for outlets
//   Future<bool> insertOutlet(Outlet o) async {
//     Database db = await instance.instace;
//     try {
//       var res = await db.insert(outletsTable, o.toJson());
//       return res != 0;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   // _query() async{
//   //   List<Map> result = await _database.rawQuery("SELECT * from outlet WHERE name= ?",[]);
//   //  }
//
//   //List<Outlet> outlet = await
//
//
//   List<Outlet> outlet =[];
//   Future<List<Outlet>> getAllOutletData() async {
//     Database db = await instance.instace;
//     var res = await db.query(outletsTable);
//     res.forEach((element) {
//       outlet.add(Outlet.fromJson(element));
//     });
//     return outlet;
//   }
//
//   Future<bool> deleteOutlet(Outlet o) async {
//     Database db = await instance.instace;
//     var res = await db.delete(outletsTable, where: 'id = ?', whereArgs: [o.outid]);
//     return res != 0;
//   }
//
//   Future<bool> deleteSyncedOutlet() async {
//     Database db = await instance.instace;
//     var res =
//         await db.rawDelete('DELETE FROM $outletsTable WHERE synced = ?', ['1']);
//     print(res);
//     return res != 0;
//   }
//
//   Future<bool> updateOutlet(Outlet o) async {
//     Database db = await instance.instace;
//     var res = await db.rawUpdate(
//         "UPDATE $outletsTable SET synced = ? WHERE id = ?", ['1', o.outid]);
//     return res == 1;
//   }
//
//   Future clearOutletData() async {
//     Database db = await instance.instace;
//
//     await db.delete(outletsTable);
//   }
//
//   //for collection
//   Future<bool> insertCollection(Collections collection) async {
//     Database db = await instance.instace;
//     try {
//       var res = await db.insert(collectionsTable, collection.toJson(true));
//       print('inserted collection data');
//       return res != 0;
//     } catch (e) {
//       print(e.message);
//       return false;
//     }
//   }
//
//   Future<List<Collections>> getAllCollectionData() async {
//     Database db = await instance.instace;
//     List<Collections> collections = [];
//     var res = await db.query(collectionsTable);
//     res.forEach((element) {
//       collections.add(Collections.fromJson(element));
//     });
//     return collections;
//   }
//
//   Future<bool> deleteCollection(Collections collection) async {
//     Database db = await instance.instace;
//     var res = await db
//         .delete(collectionsTable, where: 'id = ?', whereArgs: [collection.id]);
//     return res == 1;
//   }
//
//   //for products
//   Future<bool> insertProducts(Product products) async {
//     Database db = await instance.instace;
//     var res = await db.insert(productsTable, products.toJson(isLocalDB: true));
//     print('inserted products data');
//     return res != 0;
//   }
//
//   Future<List<Product>> getAllProductsData() async {
//     Database db = await instance.instace;
//     List<Product> products = [];
//     var res = await db.query(productsTable);
//     res.forEach((element) {
//       products.add(Product.fromJson(element, isLocalDB: true));
//     });
//     return products;
//   }
//
//   Future<bool> deleteAllProducts() async {
//     Database db = await instance.instace;
//     var res = await db.delete(productsTable);
//     return res != 0;
//   }
//
//   //for bank
//   Future<bool> insertBank(Bank bank) async {
//     Database db = await instance.instace;
//     var res = await db.insert(bankTable, bank.toJson());
//     print('inserted bank data');
//     return res != 0;
//   }
//
//   Future<List<Bank>> getAllBankData() async {
//     Database db = await instance.instace;
//     List<Bank> bank = [];
//     var res = await db.query(bankTable);
//     res.forEach((element) {
//       bank.add(Bank.fromJson(element));
//     });
//     return bank;
//   }
//
//   Future<bool> deleteAllBanks() async {
//     Database db = await instance.instace;
//     var res = await db.delete(bankTable);
//     return res != 0;
//   }
//
//   //for sales
//   Future<bool> insertSales(Sales sales) async {
//     Database db = await instance.instace;
//     var res = await db.insert(salesTable, sales.toJson(true));
//     print('inserted sales data');
//     return res != 0;
//   }
//
//   Future<List<Sales>> getAllSalesData() async {
//     Database db = await instance.instace;
//     List<Sales> sales = [];
//     var res = await db.query(salesTable);
//     res.forEach((element) {
//       sales.add(Sales.fromJson(element));
//     });
//     return sales;
//   }
//
//   Future<bool> deleteSales(Sales sales) async {
//     Database db = await instance.instace;
//     var res =
//         await db.delete(salesTable, where: 'id = ?', whereArgs: [sales.id]);
//     return res == 1;
//   }
// }

import 'package:mobitrack_dv_flutter/model/bank.dart';
import 'package:mobitrack_dv_flutter/model/collections.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';

import '../model/address.dart';
import '../model/check_in_out.dart';
import '../model/outlet_post.dart';
import '../model/routes.dart';

class DatabaseHelper {
  static final _databaseName = "mobitrac_dv.db";
  static final _databaseVersion = 1;

  static final locationTable = 'location';
  static final routeTable = 'route';
  static final checkinoutTable = 'checkinout';
  static final outletsTable = 'outlets';
  static final collectionsTable = 'collections';
  static final productsTable = 'products';
  static final salesTable = 'sales';
  static final bankTable = 'banks';


  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get instace async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var path = await getDatabasesPath() + '/' + _databaseName;
    return await openDatabase(path, onOpen: (db) {
      _onCreate(db, _databaseVersion);
    }, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //create user table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $locationTable (
              id TEXT,
              latitude TEXT,
              longitude TEXT,
              date TEXT,
              checkinout_id TEXT,
              outlet_id TEXT
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $routeTable (
              id INTEGER,
              routename TEXT,
              day TEXT
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $checkinoutTable (
              checkin_device_time TEXT ,
               id TEXT  
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $bankTable (
              id INTEGER,
              bank_name TEXT,
              bank_code TEXT,
              created_at TEXT,
              updated_at TEXT
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $outletsTable (
              id TEXT,
              outlet_id TEXT,
              name TEXT,
              owner_name TEXT,
              contact TEXT,
              type TEXT,
              saleOfficer_id TEXT,
              townId TEXT,
              channelId TEXT,
              categoryId TEXT
              routeId TEXT,
              latitude TEXT,
              longitude TEXT,
              image TEXT,
              visitFrequency TEXT,
              distributor_id TEXT,
              synced TEXT
              )
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $collectionsTable (
              id TEXT PRIMARY KEY,
              distributor_id TEXT,
              mode TEXT,
              bank_name TEXT,
              cheque_no TEXT,
              cheque_photo TEXT,
              amount TEXT,
              account_of TEXT,
              remarks TEXT,
              device_time TEXT,
              created_at TEXT,
              updated_at TEXT,
              synced INTEGER
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $productsTable (
              id INTEGER  ,
              name TEXT,
              unit TEXT,
              value INTEGER,
              created_at TEXT,
              updated_at TEXT,
              batches TEXT
              )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $salesTable (
              sold_at TEXT ,
              outlet_id TEXT ,
              outlet_name TEXT,
              orders TEXT,
              total_cost TEXT  ,
              id TEXT  ,
              remarks TEXT  ,
              latitude TEXT ,
              remarks_image  TEXT,
              longitude TEXT  ,
              route_id TEXT  
              )
          ''');
  }
  Future<LocationModel> insertLocationData(
      LocationModel locationModel, bool inOutlet) async {
    Database db = await instance.instace;
    await db.insert(locationTable, locationModel.toJson(inOutlet));
    // print('inserted location data');
    return locationModel;
  }

  Future<List<LocationModel>> getAllLocationData() async {
    Database db = await instance.instace;
    List<LocationModel> location = [];
    var res = await db.query(locationTable);
    res.forEach((element) {
      location.add(LocationModel.fromJson(element));
    });
    return location;
  }

  Future<int> removeLocationData(String id) async {
    Database db = await instance.instace;
    return await db.delete(locationTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeAllLocationData() async {
    Database db = await instance.instace;
    return await db.delete(locationTable);
  }
  //for checkinout
  Future<bool> insertcheckin(CheckInOut checkinout) async{
    Database db = await instance.instace;
    try{
      var res = await db.insert(checkinoutTable, checkinout.toJson());
      return res != 0;
    }catch(e){
      return false;
    }
  }
  Future<List<CheckInOut>> getcheckin() async{
    Database db = await instance.instace;
    List<CheckInOut> checkinout = [];
    var res = await db.query(checkinoutTable);
    res.forEach((element) {
      checkinout.add(CheckInOut.fromJson(element));
    });
  }
   //for routes
  Future<bool> insertroutes(Routes route) async{
    Database db = await instance.instace;
    try{

      var res = await db.insert(routeTable, route.toJson());
      print("inserted");
      return res != 0;

    }catch(e){
      return false;
    }
  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await  instance.instace;
    return db.query(salesTable, orderBy: "id");
  }
  Future<List<Routes>> getroute() async{
    Database db = await instance.instace;
    List<Routes> route = [];
    var res = await db.query(routeTable, orderBy: "id");
    res.forEach((element) {
      route.add(Routes.fromJson(element));
    });
  }
  Future<bool> deleteSyncedroute() async {
    Database db = await instance.instace;
    var res =
    await db.rawDelete('DELETE FROM $routeTable ');
    print(res);
    return res != 0;
  }
  Future clearrouteData() async {
    Database db = await instance.instace;
    await db.delete(routeTable);
  }
  static Future<List<Routes>> getItemsm() async {
    final db = await instance.instace;
    final List<Map<String, Object>> queryResult =
    await db.query(routeTable);
    return queryResult.map((e) => Routes.fromJson(e)).toList();
  }
  static Future<List<Map<String, dynamic>>> getItemsss() async {
    final db = await instance.instace;
    return db.query(routeTable );
  }
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await instance.instace;
    var result = await db.query(routeTable );
    return result;
  }
  //for outlets.
  Future<bool> insertOutlet(OutletPost  o) async {
    Database db = await instance.instace;
    try {
      var res = await db.insert(outletsTable, o.toJson());
      return res != 0;
      print('inserted sales data');
    } catch (e) {
      return false;
    }
  }
  Future<List<OutletPost>> getAllOutletData() async {
    Database db = await instance.instace;
    List<OutletPost> outlets = [];
    var res = await db.query(outletsTable);
    res.forEach((element) {
      outlets.add(OutletPost.fromJson(element));
    });
    return outlets;
  }
  Future<bool> deleteOutlet(OutletPost o) async {
    Database db = await instance.instace;
    var res = await db.delete(outletsTable, where: 'id = ?', whereArgs: [o.id]);
    return res != 0;
  }

  Future<bool> deleteSyncedOutlet() async {
    Database db = await instance.instace;
    var res =
    await db.rawDelete('DELETE FROM $outletsTable WHERE synced = ?', ['1']);
    print(res);
    return res != 0;
  }

  Future<bool> updateOutlet(Outlet o) async {
    Database db = await instance.instace;
    var res = await db.rawUpdate(
        "UPDATE $outletsTable SET synced = ? WHERE id = ?", ['1', o.id]);
    return res == 1;
  }

  Future clearOutletData() async {
    Database db = await instance.instace;
    await db.delete(outletsTable);
  }

  //for collection
  Future<bool> insertCollection(Collections collection) async {
    Database db = await instance.instace;
    try {
      var res = await db.insert(collectionsTable, collection.toJson(true));
      print('inserted collection data');
      return res != 0;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<List<Collections>> getAllCollectionData() async {
    Database db = await instance.instace;
    List<Collections> collections = [];
    var res = await db.query(collectionsTable);
    res.forEach((element) {
      collections.add(Collections.fromJson(element));
    });
    return collections;
  }

  Future<bool> deleteCollection(Collections collection) async {
    Database db = await instance.instace;
    var res = await db
        .delete(collectionsTable, where: 'id = ?', whereArgs: [collection.id]);
    return res == 1;
  }

  //for products
  Future<bool> insertProducts(Product products) async {
    Database db = await instance.instace;
    var res = await db.insert(productsTable, products.toJson(isLocalDB: true));
    print('inserted products data');
    return res != 0;
  }

  Future<List<Product>> getAllProductsData() async {
    Database db = await instance.instace;
    List<Product> products = [];
    var res = await db.query(productsTable);
    res.forEach((element) {
      products.add(Product.fromJson(element, isLocalDB: true));
    });
    return products;
  }

  Future<bool> deleteAllProducts() async {
    Database db = await instance.instace;
    var res = await db.delete(productsTable);
    return res != 0;
  }

  //for bank
  Future<bool> insertBank(Bank bank) async {
    Database db = await instance.instace;
    var res = await db.insert(bankTable, bank.toJson());
    print('inserted bank data');
    return res != 0;
  }

  Future<List<Bank>> getAllBankData() async {
    Database db = await instance.instace;
    List<Bank> bank = [];
    var res = await db.query(bankTable);
    res.forEach((element) {
      bank.add(Bank.fromJson(element));
    });
    return bank;
  }

  Future<bool> deleteAllBanks() async {
    Database db = await instance.instace;
    var res = await db.delete(bankTable);
    return res != 0;
  }

  //for sales
  Future<bool> insertSales(Sales sales) async {
    Database db = await instance.instace;
    var res = await db.insert(salesTable, sales.toJson(true));
    print('inserted sales data');
    return res != 0;
  }

  // Future<List<Sales>> getItems() async {
  //   Database db = await instance.instace;
  //   final List<Map<String, Object>> queryResult =
  //   await db.query(salesTable, orderBy: NoteColumn.createdAt);
  //   return queryResult.map((e) => Note.fromMap(e)).toList();
  // }

  // static Future<List<Map<String, dynamic>>> getItems() async {
  //   final db = await  instance.instace;
  //   return db.query(salesTable, orderBy: "id");
  // }
  Future<List<Sales>> getAllSalesData() async {
    Database db = await instance.instace;
    List<Sales> sales = [];
    var res = await db.query(salesTable);
    res.forEach((element) {
      sales.add(Sales.fromJson(element));
    });
    return sales;
  }

  Future<bool> deleteSales(Sales sales) async {
    Database db = await instance.instace;
    var res =
    await db.delete(salesTable, where: 'id = ?', whereArgs: [sales.id]);
    return res == 1;
  }
}

