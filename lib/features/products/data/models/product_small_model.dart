import 'dart:convert';

import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';


class ProductModel extends ProductsEntity{
  const ProductModel({required super.id,required  super.title,required super.price,required super.imgPath,
    required super.catTitle, required super.desc, required super.discount,required super.discountRate,
    required super.stockStatus,required super.quantity,
    required super.categoryList,
    required super.commentCount,
  });

  static List<ProductModel> listModelFromJson(String str) =>
      List<ProductModel>.from(
          json.decode(str).map((x) => ProductModel.fromJson(x)));


  static ProductModel fromJson(Map<String, dynamic> jsonObject) {
    return ProductModel(
      id: jsonObject['ID'],
      title: jsonObject['post_title'],
      catTitle: jsonObject['post_title'],
      discount: double.parse(jsonObject['details'][0]['max_price'].toString()),
      discountRate: calcDiscountRate(double.parse(jsonObject['details'][0]['max_price'].toString()),double.parse(jsonObject['details'][0]['min_price'].toString())),
      price: double.parse(jsonObject['details'][0]['min_price'].toString()),
      desc: jsonObject['post_title'],
      stockStatus: jsonObject['details'][0]['stock_status']=="instock",
      imgPath: jsonObject['photo'].toString()!="[]"?jsonObject['photo'][0]['photo'][0]['guid']:"",
      commentCount: jsonObject['comment_count'],
      quantity: 1,
      categoryList: jsonObject['category'] != null && jsonObject['category'].toString()!="[]"? CategoriesModel.listModelFromJson(jsonEncode(jsonObject['category'])):[],
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

class ProductComments {
  final int productID;
  final String commentContent;
  final String commentType;
  final String date;
  final int userID;
  final String userName;

  ProductComments({required this.productID,required this.commentContent,required this.commentType,required this.userID,required this.date,required this.userName});

  static ProductComments fromJson(Map<String, dynamic> jsonObject) {
    return ProductComments(
      productID: jsonObject['comment_post_ID'],
      commentContent: jsonObject['comment_content']??"",
      commentType: jsonObject['comment_agent']??"",
      date: jsonObject['comment_date']??DateTime.now(),
      userID: jsonObject['user_id']??0,
      userName: jsonObject['user']['user_nicename']??"",
    );
  }

}