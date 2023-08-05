


import 'dart:convert';

import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';



class CategoriesModel  extends CategoriesEntity{
  const CategoriesModel(
      {required super.id,
        required  super.imgPath,
        required  super.title,
      });

  static CategoriesModel fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      title: json['name'],
      imgPath: json['icon'],
    );
  }


  static CategoriesModel fromJsonProducts(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['taxonomy'],
      title: json['name'],
      imgPath: json['guid'],
    );
  }


  static List<CategoriesModel> listModelFromJson(String str) =>
      List<CategoriesModel>.from(
          json.decode(str).map((x) => CategoriesModel.fromJsonProducts(x)));

}
