import 'dart:io';
import 'dart:async';

import 'package:shop/models/address_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AddressHelper {
  static AddressHelper _addressHelper;

  static Database _database;

  String addressTable = 'address_table';
  String addressId = 'addId';
  String addressName = 'addName';
  String addressLocality = 'addLocality';
  String addressLandmark = 'addLandmark';
  String addressPhoneNumber = 'addPhoneNumber';
  String addressPinCode = 'addPincode';
  

  AddressHelper._createInstance();

  factory AddressHelper() {
    if (_addressHelper == null) {
      _addressHelper = AddressHelper._createInstance();
    }

    return _addressHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'address.db';
    var addressDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return addressDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $addressTable($addressId TEXT PRIMARY KEY , $addressName TEXT , $addressLocality TEXT ,$addressLandmark TEXT, $addressPinCode TEXT, $addressPhoneNumber TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAddressList() async {
    Database db = await this.database;
    var result = await db.query(addressTable);
    return result;
  }

  Future<int> insertAddress(AddressModel addressItems) async {
    Database db = await this.database;
    var result = await db.insert(addressTable, addressItems.toMap());
    return result;
  }

  Future<int> deleteAddress(String id) async {
    Database db = await this.database;
    var result =
        await db.delete(addressTable, where: '$addressId = ?', whereArgs: [id]);
    return result;
  }

 

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $addressTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
