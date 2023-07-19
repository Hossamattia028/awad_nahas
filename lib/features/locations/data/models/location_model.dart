import 'dart:convert';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity{
  const LocationModel({required super.address,required super.phone,required super.city,required super.country,required super.id,required super.type,required super.lat,required super.long});

  static List<LocationModel> locationListFromJson(String str) =>
      List<LocationModel>.from(
          json.decode(str).map((x) => LocationModel.fromJson(x)));


  static LocationModel fromJson(Map<String, dynamic> jsonObject) {
    return LocationModel(
      id: jsonObject['id'],
      address: jsonObject['street2']??"",
      city:  jsonObject['city']??"",
      country:  jsonObject['country']??"",
      phone:  jsonObject['phone'],
      type:  getLocationType(jsonObject['type']),
      lat:  double.parse(jsonObject['latitude']??"0"),
      long:  double.parse(jsonObject['longitude'] ?? "0"),
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
