
import 'dart:convert';

import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity{
  const LocationModel({required super.address1,required super.address2,required super.city,required super.phone,
    required super.state,required super.country,required super.id,required super.type,
    required super.lat,required super.long,required super.postCode,required super.lastName,required super.firstName,
    required super.email,super.hours,
    required super.locationType
  });

  static List<LocationModel> localLocationListFromJson(String str) =>
      List<LocationModel>.from(
          json.decode(str).map((x) => LocationModel.fromJsonLocal(x,'local')));


  static LocationModel fromJson(Map<String, dynamic> jsonObject,type) {
    return LocationModel(
      id: jsonObject['id']??0,
      address1: (jsonObject['billing_address_1']??jsonObject['shipping_address_1']).toString().replaceAll("null", ""),
      address2:  (jsonObject['billing_address_2']??jsonObject['shipping_address_2']).toString().replaceAll("null", ""),
      city:  (jsonObject['billing_city']??jsonObject['shipping_city']).toString().replaceAll("null", ""),
      country:  "SA",
      phone:  (jsonObject['billing_phone']??jsonObject['shipping_phone']).toString().replaceAll("null", ""),
      type:  type.toString(),
      lat:  double.parse(jsonObject['latitude']??"0"),
      long:  double.parse(jsonObject['longitude'] ?? "0"),
      state: (jsonObject['billing_state']??jsonObject['shipping_state']).toString().replaceAll("null", ""),
      postCode: (jsonObject['billing_postcode']??jsonObject['shipping_postcode']).toString().replaceAll("null", ""),
      firstName: (jsonObject['billing_first_name']??jsonObject['shipping_first_name']).toString().replaceAll("null", ""),
      lastName:  (jsonObject['billing_last_name']??jsonObject['shipping_last_name']).toString().replaceAll("null", ""),
      email:  (jsonObject['billing_email']??jsonObject['shipping_email']).toString().replaceAll("null", ""),
      hours: jsonObject['hours']??[],
      locationType: getTypeForBillingAndShipping(type.toString()),
    );
  }

  static getTypeForBillingAndShipping(String type){
    if(type=="shipping"){
      return SharedPref().getPreferenceString(Constants.shippingType);
    }else if(type=="billing"){
      return SharedPref().getPreferenceString(Constants.billingType);
    }
    return type;
  }

  static String getLocationType(var type){
    if(type=="work"){
      return translate("map.work");
    }else{
      return translate("map.home");
    }
  }

  static Map<String, dynamic> toJson(LocationEntity location) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = location.firstName.toString();
    data['last_name'] = location.lastName.toString();
    data['line1'] = location.address1.toString();
    data['line2'] = "${location.address1} ${location.address2} ".toString().replaceAll("null", "");
    data['region'] = "SA";
    data['postal_code'] = location.postCode.toString();
    data['city'] = location.city.toString()==""?location.address2.toString() : location.city.toString();
    data['country'] = "SA";
    data['country_code'] = "SA";
    data['phone_number'] = location.phone.toString();
    return data;
  }

  static Map<String, dynamic> toJsonLocal(LocationEntity location,String type) {
    var address1 = location.address1.toString().characters.length>=50?location.address1.toString().substring(0,50):location.address1.toString().replaceAll("null", "");
    var address2 = location.address2.toString().characters.length>=50?location.address2.toString().substring(0,50):location.address2.toString().replaceAll("null", "");
    return {
      "id":int.tryParse(location.id.toString())??(DateTime.now().millisecond),
      '${type}_address_1': address1,
      '${type}_address_2': address2,
      '${type}_city': location.city.toString()==""? location.address2.toString().replaceAll("null", ""):  location.city.toString().replaceAll("null", ""),
      '${type}_country': "SA",
      '${type}_phone': location.phone,
      '${type}_email': location.email,
      '${type}_state': location.state,
      '${type}_postcode': location.postCode,
      '${type}_first_name': Util.getName(),
      '${type}_last_name': "",
      'location_type': location.locationType ?? "",
    };
  }

  static LocationModel fromJsonLocal(Map<String, dynamic> jsonObject,type) {
    return LocationModel(
        id: jsonObject['id']??0,
        address1: jsonObject['${type}_address_1'] ?? "",
        address2:  jsonObject['${type}_address_2'] ?? "",
        country:  "SA",
        phone:  jsonObject['${type}_phone'] ?? "",
        city: jsonObject['${type}_city'] ?? "",
        type:  type,
        lat:  0.0,
        long:  0.0,
        state: jsonObject['${type}_state'] ?? "",
        postCode: jsonObject['${type}_postcode'] ?? "",
        firstName: jsonObject['${type}_first_name'] ?? "",
        lastName:  jsonObject['${type}_last_name'] ?? "",
        email:  jsonObject['${type}_email'] ?? "",
        locationType: jsonObject['location_type'] ?? "",
    );
  }

  /// for [unit_testing]
  static LocationModel fromJsonTesting(Map<String, dynamic> jsonObject,type) {
    return LocationModel(
      id: jsonObject['id']??0,
      address1: (jsonObject['billing_address_1']??jsonObject['shipping_address_1']).toString().replaceAll("null", ""),
      address2:  (jsonObject['billing_address_2']??jsonObject['shipping_address_2']).toString().replaceAll("null", ""),
      city:  (jsonObject['billing_city']??jsonObject['shipping_city']).toString().replaceAll("null", ""),
      country:  "SA",
      phone:  (jsonObject['billing_phone']??jsonObject['shipping_phone']).toString().replaceAll("null", ""),
      type:  type.toString(),
      lat:  double.parse(jsonObject['latitude']??"0"),
      long:  double.parse(jsonObject['longitude'] ?? "0"),
      state: (jsonObject['billing_state']??jsonObject['shipping_state']).toString().replaceAll("null", ""),
      postCode: (jsonObject['billing_postcode']??jsonObject['shipping_postcode']).toString().replaceAll("null", ""),
      firstName: (jsonObject['billing_first_name']??jsonObject['shipping_first_name']).toString().replaceAll("null", ""),
      lastName:  (jsonObject['billing_last_name']??jsonObject['shipping_last_name']).toString().replaceAll("null", ""),
      email:  (jsonObject['billing_email']??jsonObject['shipping_email']).toString().replaceAll("null", ""),
      hours: jsonObject['hours']??[],
      locationType: type.toString(),
    );
  }

  Map<String, dynamic> toJSon() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    return data;
  }

}

class AddressModel extends AddressEntity{
  const AddressModel({required super.shippingAddress, required super.billingAddress});

  static AddressModel fromJson(Map<String, dynamic> jsonObject) {
    return AddressModel(
      shippingAddress: LocationModel.fromJson(jsonObject['shipping'], "shipping"),
      billingAddress: LocationModel.fromJson(jsonObject['billing'], "billing"),
    );
  }
}
