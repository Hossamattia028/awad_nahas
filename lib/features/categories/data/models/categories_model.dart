


import 'dart:convert';

import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';



class CategoriesModel  extends CategoriesEntity{
  const CategoriesModel(
      {required super.id,
        required  super.imgPath,
        required  super.title,
        required  super.desc,
        required super.iconPath,
        required super.darkIcon,
        required super.lightIcon,
        required super.isArabic,
        required super.parentID,
        required super.productsCount,
        required super.enableHomeScreen,
      });

  static CategoriesModel fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      title: json['name'],
      desc: json['desc']??"",
      imgPath: json['image'],
      iconPath: json['icon'],
      darkIcon: json['dark_icon'],
      lightIcon: json['light_icon'],
      isArabic: json['is_arabic'],
      enableHomeScreen: json['show_on_mobile'] ?? false,
      parentID: (json['parent']??0).toString(),
      productsCount: int.parse((json['products_count']!=null&&json['products_count']!=""?json['products_count']:0).toString()),
    );
  }


  static CategoriesModel fromJsonProducts(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['term_id'],
      title: json['name'],
      desc: json['desc']??"",
      imgPath: json['guid']??"",
      iconPath: json['icon']??"",
      darkIcon: json['dark_icon'],
      lightIcon: json['light_icon'],
      isArabic: json['is_arabic']??false,
      enableHomeScreen: json['show_on_mobile'] ?? false,
      parentID: (json['parent']??0).toString(),
      productsCount: int.parse((json['products_count']!=null&&json['products_count']!=""?json['products_count']:0).toString()),
    );
  }


  static List<CategoriesModel> listModelFromJson(String str) =>
      List<CategoriesModel>.from(
          json.decode(str).map((x) => CategoriesModel.fromJsonProducts(x)));

}
