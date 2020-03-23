class AddressModel {
  final String name;
  final String locality;
  final String landmark;
  final String pincode;
  final String phNumber;

  AddressModel({
    this.name,
    this.locality,
    this.landmark,
    this.pincode,
    this.phNumber,
  });

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['addId'] = name+locality+landmark+phNumber ;
    map['addName'] = name;
    map['addLocality'] = locality;
    map['addLandmark'] = landmark;
    map['addPincode'] = pincode;
    map['addPhoneNumber'] = phNumber; 
    return map;
  }
}
