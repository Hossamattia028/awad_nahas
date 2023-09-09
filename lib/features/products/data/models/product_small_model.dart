import 'dart:convert';
import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/products/data/models/product_attributes.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';


class ProductModel extends ProductsEntity{
  const ProductModel({
    required super.id,
    required super.sku,
    required  super.title,required super.price,
    required super.imgPath,
    required super.images,
    required super.catTitle,
    required super.desc,
    required super.attributesDes,
    required super.discount,required super.discountRate,
    required super.stockStatus,required super.quantity,
    required super.categoryList,
    required super.catID,
    required super.brandID,
    required super.commentCount,
    required super.isArabic,
    required super.reviewsList,
    required super.date,
    required super.averageRate,
    required super.attributes,
  });

  static List<ProductModel> listModelFromJson(String str) =>
      List<ProductModel>.from(
          json.decode(str).map((x) => ProductModel.fromJson(x)));


  static ProductModel fromJson(Map<String, dynamic> jsonObject) {
    List<String> list = [];
    if(jsonObject['images']!=null && jsonObject['images'].toString()!="[]"){
      for(var i in jsonObject['images']){
        list.add(i.toString());
      }
    }
    return ProductModel(
      id: jsonObject['id'],
      sku: jsonObject['sku'] ?? "",
      title: jsonObject['title'],
      catTitle: jsonObject['post_title']??"",
      discount: double.parse((jsonObject['price'] ?? "0").toString()),
      discountRate: double.parse((jsonObject['price'] ?? "0").toString()),
      price: double.parse((jsonObject['regular_price'] ?? "0").toString()),
      desc: jsonObject['desc'] ?? "",
      attributesDes: jsonObject['attributes_des'] ?? "",
      stockStatus:  jsonObject['stock_status'] == "instock",
      imgPath: jsonObject['image']??"",
      images: list,
      commentCount: 1,
      quantity: 1,
      isArabic:jsonObject['is_arabic'],
      categoryList: jsonObject['categories']!=null ? CategoriesModel.listModelFromJson(jsonEncode(jsonObject['categories'])):[],
      catID: int.parse((jsonObject['cat_id']??"0").toString()),
      brandID: int.parse((jsonObject['brand_id']??"0").toString()),
      reviewsList: ProductComments.listModelFromJson(jsonEncode(jsonObject['reviews'])),
      date: jsonObject['date'] ?? "",
      averageRate: jsonObject['average_rating'] ?? "0",
      attributes: ProductAttributes.fromJson(jsonObject),
    );
  }

  static double calcDiscountRate(double price,double newPrice){
    return double.tryParse(((price-newPrice) * (100/price)).toDouble().toStringAsFixed(2))??0.0;
  }

  static double calcDiscount(double price,double newPrice){
    return price-newPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    return data;
  }
}


