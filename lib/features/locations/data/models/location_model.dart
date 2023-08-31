
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity{
  const LocationModel({required super.address1,required super.address2,required super.phone,
    required super.state,required super.country,required super.id,required super.type,
    required super.lat,required super.long,required super.postCode,required super.lastName,required super.firstName,
    required super.email,super.hours});

  // static List<LocationModel> locationListFromJson(String str) =>
  //     List<LocationModel>.from(
  //         json.decode(str).map((x) => LocationModel.fromJson(x)));


  static LocationModel fromJson(Map<String, dynamic> jsonObject,type) {
    return LocationModel(
      id: jsonObject['id']??0,
      address1: (jsonObject['billing_address_1']??jsonObject['shipping_address_1']).toString().replaceAll("null", ""),
      address2:  (jsonObject['billing_address_2']??jsonObject['shipping_address_2']).toString().replaceAll("null", ""),
      country:  (jsonObject['billing_country']??jsonObject['shipping_country']).toString().replaceAll("null", ""),
      phone:  (jsonObject['billing_phone']??jsonObject['shipping_phone']).toString().replaceAll("null", ""),
      type:  type,
      lat:  double.parse(jsonObject['latitude']??"0"),
      long:  double.parse(jsonObject['longitude'] ?? "0"),
      state: (jsonObject['billing_state']??jsonObject['shipping_state']).toString().replaceAll("null", ""),
      postCode: (jsonObject['billing_postcode']??jsonObject['shipping_postcode']).toString().replaceAll("null", ""),
      firstName: (jsonObject['billing_first_name']??jsonObject['shipping_first_name']).toString().replaceAll("null", ""),
      lastName:  (jsonObject['billing_last_name']??jsonObject['shipping_last_name']).toString().replaceAll("null", ""),
      email:  (jsonObject['billing_email']??jsonObject['shipping_email']).toString().replaceAll("null", ""),
      hours: jsonObject['hours']??[]
    );
  }

  static String getLocationType(var type){
    if(type=="work"){
      return translate("map.work");
    }else{
      return translate("map.home");
    }
  }
}

class AddressModel extends AddressEntity{
  const AddressModel({required super.shippingAddress, required super.billingAddress});

  // static List<dynamic> listFromJson(String str) =>
  //     List<AddressModel>.from(
  //         json.decode(str).map((x) => AddressModel.fromJson(x)));

  static AddressModel fromJson(Map<String, dynamic> jsonObject) {
    return AddressModel(
      shippingAddress: LocationModel.fromJson(jsonObject['shipping'], "shipping"),
      billingAddress: LocationModel.fromJson(jsonObject['billing'], "billing"),
    );
  }
}
