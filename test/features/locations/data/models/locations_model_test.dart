import 'dart:convert';

import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';



void main(){
  const tLocation =  LocationModel(
      address1: "address1", address2: "address2", city: "city", phone: "201123876427", state: "state", country: "country",
      id: 0, type: "", lat: 23, long: 23, postCode: "postCode",
      lastName: "lastName", firstName: "firstName", email: "email", locationType: "locationType");

  test("should be a subclass of LocationEntity", () async{
    expect(tLocation, isA<LocationEntity>());
  });

  group("from json examples", () {
    test("should be data valid", () async{
      //arrange
      final Map<String,dynamic> jsonMap = json.decode(fixture('location_example.json'));

      //act
      final result = LocationModel.fromJsonTesting(jsonMap,"shipping");
      // final result = LocationModel.fromJsonTesting(jsonMap,"billing");

      //assert
      expect(result, tLocation);
    });

  });

  group("to json examples", () {
    test("should be return a json map", () async{
      //arrange
      final expectedMap = {
        'ID':0
      };

      //act
      final result = tLocation.toJSon();

      //assert
      expect(result, expectedMap);
    });

  });

}