import 'package:mobitrack_dv_flutter/model/bank.dart';
import 'package:mobitrack_dv_flutter/model/collections.dart';
import 'package:mobitrack_dv_flutter/model/outlet.dart';
import 'package:mobitrack_dv_flutter/model/products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';

class DatabaseHelper {
  static final _databaseName = "mobitrac_dv.db";
  static final _databaseVersion = 1;

  static final locationTable = 'location';
  static final outletsTable = 'outlets';
  static final collectionsTable = 'collections';
  static final productsTable = 'products';
  static final salesTable = 'sales';
  static final bankTable = 'banks';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get instace async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var path = await getDatabasesPath() + '/' + _databaseName;
    return await openDatabase(path, onOpen: (db) {
      _onCreate(db, _databaseVersion);
    }, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //create user table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $locationTable (
              id TEXT,
              latitude REAL,
              longitude REAL,
              time TEXT
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
              id INTEGER PRIMARY KEY,
              sales_officer_id INTEGER,
              name TEXT,
              owner_name TEXT,
              contact TEXT,
              type TEXT,
              latitude REAL,
              longitude REAL,
              address TEXT,
              synced INTEGER
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
              id INTEGER PRIMARY KEY,
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
              id INTEGER PRIMARY KEY,
              distributor_id TEXT,
              batch_id TEXT,
              product_id TEXT,
              quantity TEXT,
              sold_at TEXT,
              outlet_id TEXT
              )
          ''');
  }

  Future<LocationModel> insertLocationData(LocationModel locationModel) async {
    Database db = await instance.instace;
    await db.insert(locationTable, locationModel.toJson());
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

  //for outlets
  Future<bool> insertOutlet(Outlet o) async {
    Database db = await instance.instace;
    try {
      var res = await db.insert(outletsTable, o.toJson());
      return res == 1;
    } catch (e) {
      return true;
    }
  }

  Future<List<Outlet>> getAllOutletData() async {
    Database db = await instance.instace;
    List<Outlet> outlets = [];
    var res = await db.query(outletsTable);
    res.forEach((element) {
      outlets.add(Outlet.fromJson(element));
    });
    return outlets;
  }

  Future<bool> deleteOutlet(Outlet o) async {
    Database db = await instance.instace;
    var res = await db.delete(outletsTable, where: 'id = ?', whereArgs: [o.id]);
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
