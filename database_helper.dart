import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'item.dart';

class DatabaseHelper {
  static DatabaseHelper _instance; //singleton instance method requires access of its variables
  static Database _database;

  //create table names
  String tableName = 'appDB';
  String colID = 'id';
  String colItem = 'item';
  String colCategory = 'category';
  String colAmount = 'amount';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to create an instance

  factory DatabaseHelper() {
    if (_instance == null) { //only create the instance if it's null
      _instance = DatabaseHelper._createInstance();
    }
    return _instance;
  }

  //getter for the database
  Future<Database> get database async {
    if (_database == null) { //if the database doesn't exist, initialize it
      _database = await initialize();
    }
    return _database;
  }

  //method to initialize database, this will return a Future of type Database
  Future<Database> initialize() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'appDatabase.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create database
  void _createDB(Database db, int ver) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $colID INTEGER PRIMARY KEY AUTOINCREMENT,
        $colItem TEXT,
        $colCategory TEXT,
        $colAmount REAL,
        $colDate TEXT)
    ''');
  }

  Future<List<Map<String, dynamic>>> getMapList() async { //sqlite returns a list of maps
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(tableName); //tableName = appDB
    return result;
  }

  Future<List<Item>> getItemList() async { //convert the map to a list of Item
    List<Map<String, dynamic>> mapList = await getMapList();
    List<Item> itemList = [];
    mapList.forEach((i) {
      itemList.add(Item.fromMap(i));
    });
    return itemList;
  }

  Future<int> insertItem(Item item) async { //takes an object of class Item, turns it into a map, then inserts it to the table
    Database db = await this.database;
    int result = await db.insert(tableName, item.toMap());
    return result;
    //return await db.execute('INSERT INTO appDB (id, item, category, amount, date) VALUES (NULL,NULL,NULL,100,NULL)');
  }

  Future<int> updateItem(Item item) async {
    Database db = await this.database;
    int result = await db.update(
      tableName,
      item.toMap(),
      where: '$colID = ?',
      whereArgs: [item.id]
    );
    return result;
  }

  Future<int> deleteItem(int id) async { //when deleting, pass the id property only
    Database db = await this.database;
    int result = await db.delete(
      tableName,
      where: '$colID = ?',
      whereArgs: [id],
    );
    return result;
  }
}
