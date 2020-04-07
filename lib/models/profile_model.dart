import 'package:shop/utils/strings.dart';

class ProfileModel {
   String providerDisplayName;
   String providerEmail;
   String providerPhoneNumber;
   String providerPhotoUrl;
   String providerName;

  ProfileModel(
      {this.providerDisplayName,
      this.providerEmail,
      this.providerName,
      this.providerPhoneNumber,
      this.providerPhotoUrl});

  Map<dynamic, dynamic> toMap() {
    Map<String, String> map = Map<String, String>();
    map[StringKeys.providerDisplayName] =
        (providerDisplayName != null) ? providerDisplayName : "";
    map[StringKeys.providerEmail] =
        (providerEmail != null) ? providerEmail : "";
    map[StringKeys.providerPhoneNumber] =
        (providerPhoneNumber != null) ? providerPhoneNumber : "";
    map[StringKeys.providerPhotoUrl] =
        (providerPhotoUrl != null) ? providerPhotoUrl : "";
    map[StringKeys.providerName] = (providerName != null) ? providerName : "";
    return map;
  }

  void fromMap(Map<dynamic,dynamic> map){
    this.providerDisplayName = map[StringKeys.providerDisplayName];
    this.providerEmail = map[StringKeys.providerEmail];
    this.providerName = map[StringKeys.providerName];
    this.providerPhoneNumber = map[StringKeys.providerPhoneNumber];
    this.providerPhotoUrl = map[StringKeys.providerPhotoUrl];
  }
}
