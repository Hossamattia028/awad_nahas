import 'dart:convert';

import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';



void main(){
  const tCategory =  CategoriesModel(id: 296, slug: "slug", imgPath: "imgPath", title: "title",
      desc: "desc", iconPath: "iconPath", darkIcon: "darkIcon", lightIcon: "lightIcon", isArabic: true,
      parentID: "", productsCount: 10, enableHomeScreen: true);

  test("should be a subclass of CategoriesEntity", () async{
    expect(tCategory, isA<CategoriesEntity>());
  });

  group("from json examples", () {

    test("should be data valid", () async{
      //arrange
      final Map<String,dynamic> jsonMap = json.decode(fixture('category_example.json'));
      //product_invalid_example.json this give error because the id is string inside the file not as integer

      //act
      final result = CategoriesModel.fromJson(jsonMap);

      //assert
      expect(result, tCategory);
    });

  });

  group("to json examples", () {

    test("should be return a json map", () async{
      //arrange
      final expectedMap = {
        'ID':296
      };

      //act
      final result = tCategory.toJson();

      //assert
      expect(result, expectedMap);
    });

  });

}