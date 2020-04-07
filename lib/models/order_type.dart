import 'package:shop/models/address_model.dart';
import 'package:shop/models/cart_items.dart';

class OrderModel {
  String orderId;
  String userId;
  bool prepaid;
  AddressModel addressModel;
  List<CartItems> cartItems;
  String phoneNumber; //only for COD/SOD
  int amount;
  String txnId;
  int noOfItems;
  bool delivered;
  String orderPlacedDate;
  String estimatedDeliveryTime;
  String paymentMode;
  bool orderIsActive;

  OrderModel({
    this.orderId,
    this.userId,
    this.prepaid,
    this.addressModel,
    this.cartItems,
    this.phoneNumber,
    this.amount,
    this.txnId,
    this.noOfItems,
    this.orderPlacedDate,
    this.estimatedDeliveryTime,
    this.paymentMode,
    this.delivered,
    this.orderIsActive,
  });

  Map<dynamic,dynamic> cartItemsListToMap(){
    var map = Map<dynamic,dynamic>();
    for(int i = 0;i<cartItems.length;i++){
      map['${i+1}'] = cartItems[i].toMap();
    }
    return map;
  }

  Map<dynamic,dynamic> toOrderMap(){
    var map = Map<dynamic,dynamic>(); 
    var innerMap = Map<String,dynamic>();
    innerMap['userId'] = userId;
    innerMap['prepaid'] = prepaid;
    innerMap['address'] = addressModel.toMap();
    innerMap['cartItems'] = cartItemsListToMap();
    innerMap['phoneNumber'] = phoneNumber;
    innerMap['amount'] = amount ;
    innerMap['noOfItems'] = noOfItems;
    innerMap['delivered'] = delivered;
    innerMap['txnId'] = txnId;
    innerMap['orderPlacedDate'] = orderId.substring(userId.length);
    innerMap['estimatedDeliveryTime'] = estimatedDeliveryTime;
    innerMap['paymentMode'] = paymentMode;
    innerMap['orderIsActive'] = orderIsActive;
    map[orderId] = innerMap;     
    return map;


  }
}
