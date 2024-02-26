import 'dart:convert';

import 'package:awad_nahas/features/products/data/models/product_attributes.dart';
import 'package:awad_nahas/features/products/data/models/product_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';



void main(){
  final tProduct =  ProductModel(id: 15432, sku: "TSF01PGUK", title: "Smeg 50's Style Retro Aesthetic 2 Slice Toaster, Pastel Green", priceWithoutTax: 20, price: 22,
      imgPath: "imgPath", images: const [], catTitle: "catTitle", desc: "desc", attributesDes: "attributesDes", discount: 20, discountRate: 1, stockStatus: false,
      quantity: 2, categoryList: const [], catID: 1, brandID: 1, commentCount: 2, isArabic: true, reviewsList: const [], date: "date", averageRate: "10",
      attributes:  ProductAttributes(height: 2, width: 2, length: 2, weight: 2, color: "color"));

  test("should be a subclass of ProductEntity", () async{
      expect(tProduct, isA<ProductsEntity>());
  });

  group("from json examples", () {

    test("should be data valid", () async{
      //arrange
      final Map<String,dynamic> jsonMap = json.decode(fixture('product_example.json'));
      //product_invalid_example.json this give error because the id is string inside the file not as integer

      //act
      final result = ProductModel.fromJson(jsonMap);

      //assert
      expect(result, tProduct);
    });

  });


  group("to json examples", () {

    test("should be return a json map", () async{
      //arrange
      final expectedMap = {
        'ID':15432
      };

      //act
      final result = tProduct.toJson();

      //assert
      expect(result, expectedMap);
    });

  });

}