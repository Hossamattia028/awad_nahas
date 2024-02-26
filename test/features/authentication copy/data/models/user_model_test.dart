import 'dart:convert';

import 'package:awad_nahas/features/authentication/data/models/user_service_model.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';



void main(){
  const tUser =  UserServiceModel(userId: 3518, userLogin: "userLogin", userName: "userName", email: "email", phoneNumber: "phoneNumber");

  test("should be a subclass of UserService", () async{
      expect(tUser, isA<UserService>());
  });

  group("from json examples", () {

    test("should be data valid", () async{
      //arrange
      final Map<String,dynamic> jsonMap = json.decode(fixture('user_example.json'));

      //act
      final result = UserServiceModel.fromJson(jsonMap);

      //assert
      expect(result, tUser);
    });

  });

  group("to json examples", () {

    test("should be return a json map", () async{
      //arrange
      final expectedMap = {
        'ID':3518
      };

      //act
      final result = tUser.toJson();

      //assert
      expect(result, expectedMap);
    });

  });

}