import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cart_items.dart';

//Cart Table database helper
class CartTableHelper{

  static CartTableHelper _databaseHelper; //Singelton CartTableHelper

  static Database _database;

  String cartTable = 'cart_table';
  String pId = 'pId';
  String pImage = 'pImage';
  String pCountOrdered = 'pCountOrdered';
  String pMrp = 'pMrp';
  String pSp = 'pSp';
  String pName = 'pName';
  String pQuantity = 'pQuantity';
  String pCategoryName = 'pCategoryName';
  String pAvailability ='pAvailability';

  CartTableHelper._createInstance();

  factory CartTableHelper(){

    if(_databaseHelper == null){
      _databaseHelper = CartTableHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'cart.db';
    var cartDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return cartDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute
    ('CREATE TABLE $cartTable($pId TEXT PRIMARY KEY  , $pImage TEXT , $pCountOrdered TEXT , $pMrp TEXT , $pSp TEXT, $pName TEXT , $pQuantity TEXT , $pCategoryName TEXT , $pAvailability TEXT)');
  }


  Future<List<Map<String, dynamic>>> getCartMapList() async{
    Database db = await this.database;
    var result = await db.query(cartTable);
    return result;
  }

  Future<int> insertCartItem(CartItems cartItems) async{
    Database db = await this.database;
    var result = await db.insert(cartTable, cartItems.toMap());
    return result;
  }

  Future<int> deleteCartItem(String id) async{
    Database db = await this.database;
    var result = await db.delete(cartTable,where: '$pId = ?',whereArgs: [id]);
    return result; 
  }

  Future<void> emptyCart()async{
    Database db = await this.database;
    await db.delete(cartTable);

  }

  Future<int> updateCart(CartItems cartItems) async{
    var db = await this.database;
    var result = await db.update(cartTable, cartItems.toMap(), where: '$pId = ?',whereArgs: [cartItems.pName+cartItems.pQuantity]);
    return result;
  }

  
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $cartTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async{
    Database db = await this.database;
    db.close();
  }

}