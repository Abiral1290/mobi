import 'package:sqflite/sqflite.dart';
import 'package:mobitrack_dv_flutter/model/location_model.dart';

class DatabaseHelper {
  static final _databaseName = "mobitrac_dv.db";
  static final _databaseVersion = 1;

  static final locationTable = 'location';

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
    var path = await getDatabasesPath() +'/'+ _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //create user table
    await db.execute('''
          CREATE TABLE $locationTable (
              id TEXT,
              latitude REAL,
              longitude REAL,
              time TEXT
              )
          ''');
  }

  Future<LocationModel> insertLocationData(LocationModel locationModel) async {
    Database db = await instance.instace;
    await db.insert(locationTable, locationModel.toJson());
    print('inserted location data');
    return locationModel;
  }

  Future<List<LocationModel>> getAllLocationData() async {
    Database db = await instance.instace;
    List<LocationModel> location = [];
    var res = await db.query(locationTable);
    res.forEach((element) {
      location.add(LocationModel.fromJson(element));
    });
    print(location);
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
}
