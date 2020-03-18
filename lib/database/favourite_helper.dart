import 'dart:io';
import 'dart:async';

import 'package:shop/models/favourite_items.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteHelper {
  static FavouriteHelper _favouriteHelper;

  static Database _database;

  String favouriteTable = 'favourite_table';
  String favId = 'favouriteId';
  String categoryType = 'categoryType';
  String productName = 'productName';
  String productImage = 'productImage';
  String productMrp = 'productMrp';
  String productSp = 'productSp';
  String productAvailability = 'productAvailability';
  String productQuantity = 'productQuantity';

  FavouriteHelper._createInstance();

  factory FavouriteHelper() {
    if (_favouriteHelper == null) {
      _favouriteHelper = FavouriteHelper._createInstance();
    }

    return _favouriteHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'favourite.db';
    var favouriteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return favouriteDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $favouriteTable($favId TEXT PRIMARY KEY  , $categoryType TEXT , $productName TEXT ,$productImage TEXT, $productMrp TEXT, $productSp TEXT, $productAvailability TEXT, $productQuantity TEXT )');
  }

  Future<List<Map<String, dynamic>>> getFavouriteMapList() async {
    Database db = await this.database;
    var result = await db.query(favouriteTable);
    return result;
  }

  Future<int> insertFavouriteItem(FavouriteItems favouriteItems) async {
    Database db = await this.database;
    var result = await db.insert(favouriteTable, favouriteItems.toMap());
    return result;
  }

  Future<int> deleteFavouriteItem(String id) async {
    Database db = await this.database;
    var result =
        await db.delete(favouriteTable, where: '$favId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateFavourite(FavouriteItems favouriteItems) async {
    var db = await this.database;
    var result = await db.update(favouriteTable, favouriteItems.toMap(),
        where: '$favId = ?',
        whereArgs: [
          favouriteItems.productName +
              favouriteItems.categoryType +
              favouriteItems.productQuantity
        ]);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $favouriteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
