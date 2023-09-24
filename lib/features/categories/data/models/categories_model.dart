


import 'dart:convert';

import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';



class CategoriesModel  extends CategoriesEntity{
  const CategoriesModel(
      {required super.id,
      required super.slug,
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
      slug: json['slug']??"",
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

  static CategoriesModel fromBrandJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      slug: json['slug']??"",
      title: json['name'],
      desc: json['desc']??"",
      imgPath: json['image'],
      iconPath: json['icon'],
      darkIcon: setLocalDarkImage(json['name'].toString().toLowerCase().trim()),//json['dark_icon']
      lightIcon: setLocalLightImage(json['name'].toString().toLowerCase().trim()),//json['light_icon']
      isArabic: json['is_arabic'],
      enableHomeScreen: json['show_on_mobile'] ?? false,
      parentID: (json['parent']??0).toString(),
      productsCount: int.parse((json['products_count']!=null&&json['products_count']!=""?json['products_count']:0).toString()),
    );
  }

  static String setLocalLightImage(String name){
    if(name.startsWith("mi") || name.startsWith("م"))return AppImages.mie;
    if(name.startsWith("sm") || name.startsWith("س"))return AppImages.smeg;
    if(name.startsWith("lie") || name.startsWith("ل"))return AppImages.lieb;
    if(name.startsWith("aeg") || name.startsWith("أ"))return AppImages.aeg;
    if(name.startsWith("ba") || name.startsWith("باو"))return AppImages.baum;
    return AppImages.logo;
  }

  static String setLocalDarkImage(String name){
    if(name.startsWith("mi") || name.startsWith("م"))return AppImages.mieDark;
    if(name.startsWith("sm") || name.startsWith("س"))return AppImages.smegDark;
    if(name.startsWith("lie") || name.startsWith("ل"))return AppImages.liebDark;
    if(name.startsWith("aeg") || name.startsWith("أ"))return AppImages.aegDark;
    if(name.startsWith("ba") || name.startsWith("باو"))return AppImages.baumDark;
    return AppImages.logo;
  }



  static CategoriesModel fromJsonProducts(Map<String, dynamic> json) {
    return CategoriesModel(
      slug: json['slug']??"",
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
