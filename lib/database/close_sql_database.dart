import 'package:shop/database/address_helper.dart';
import 'package:shop/database/cartTable_helper.dart';
import 'package:shop/database/favourite_helper.dart';

class CloseAllSqlDatabase{
  
  AddressHelper _addressHelper = AddressHelper();
  CartTableHelper _cartTableHelper = CartTableHelper();
  FavouriteHelper _favouriteHelper = FavouriteHelper();
  
  void close(){
    _addressHelper.close();
    _cartTableHelper.close();
    _favouriteHelper.close();
  }

}