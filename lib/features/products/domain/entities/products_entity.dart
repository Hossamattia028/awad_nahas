import 'dart:convert';

import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/products/data/models/product_attributes.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:equatable/equatable.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';

class ProductsEntity extends Equatable{
  final int id;
  final String sku;
  final String imgPath;
  final List<String>? images;
  final String title;
  final String catTitle;
  final String desc;
  final String? attributesDes;
  final double priceWithoutTax;
  final double price;
  final double discount;
  final double discountRate;
  final bool stockStatus;
  final int quantity;
  final int commentCount;
  final bool? isArabic;
  final int catID;
  final int? brandID;
  final List<CategoriesEntity> categoryList;
  final List<ProductComments>? reviewsList;
  final String? date;
  final String? averageRate;
  final ProductAttributes? attributes;
  
  /// this parent products ids for Deals List
  final List<String>? discountParentProduct;

  const ProductsEntity({
    required this.title,
    required this.catTitle,
    required this.desc,
    this.attributesDes,
    required this.id,
    required this.sku,
    required this.imgPath,
    this.images,
    required this.priceWithoutTax,
    required this.price,
    required this.discount,
    required this.discountRate,
    required this.stockStatus,required this.quantity,
    required this.categoryList,
    required this.catID,
    this.brandID,
    this.isArabic,
    this.reviewsList,
    required this.commentCount,
    this.date,
    this.averageRate,
    this.attributes,
    this.discountParentProduct
  });

  @override
  List<Object?> get props => [id,sku];

  static ProductsEntity fromJsonLocal(Map<String, dynamic> jsonObject) {
    List<String> list = [];
    if(jsonObject['images']!=null && jsonObject['images'].toString()!="[]"){
      for(var i in jsonObject['images']){
        list.add(i.toString());
      }
    }
    return ProductsEntity(
      id: jsonObject['id'],
      sku: jsonObject['sku'] ?? "",
      title: jsonObject['title'],
      catTitle: jsonObject['post_title']??"",
      discount: double.parse((jsonObject['price'] ?? "0").toString()),
      discountRate: double.parse((jsonObject['price'] ?? "0").toString()),
      price: double.parse((jsonObject['regular_price'] ?? "0").toString()),
      priceWithoutTax: double.parse((jsonObject['price_without_tax'] ?? "0").toString()),
      desc: jsonObject['desc'] ?? "",
      attributesDes: jsonObject['attributes_des'] ?? "",
      stockStatus:  jsonObject['stock_status'] == "instock",
      imgPath: jsonObject['image']??"",
      images: list,
      commentCount: 1,
      discountParentProduct: getParentDiscountIDS(jsonObject),
      quantity: jsonObject['quantity'] ?? 1,
      isArabic:jsonObject['is_arabic'],
      categoryList: jsonObject['categories']!=null ? CategoriesModel.listModelFromJsonLocal(jsonObject['categories']):[],
      catID: int.parse((jsonObject['cat_id']??"0").toString()),
      brandID: int.parse((jsonObject['brand_id']??"0").toString()),
      reviewsList: jsonObject['reviews']==null || jsonObject['reviews'].toString()=="[]" ? [] : ProductComments.listModelFromJson(jsonObject['reviews']),
      date: jsonObject['date'] ?? "",
      averageRate: jsonObject['average_rating'] ?? "0",
      attributes: ProductAttributes.fromJson(jsonObject),
    );
  }

  static Map<String, dynamic> toJsonLocal(ProductsEntity product) {
    return {
      "id":int.tryParse(product.id.toString()),
      'sku': product.sku.toString(),
      'title': product.title.toString(),
      'post_title': product.catTitle,
      'desc': product.desc.toString(),
      'image': product.imgPath.toString(),
      "images":product.images,
      "is_arabic":product.isArabic,
      'regular_price': double.parse(product.price.toString()),
      'price': double.parse(product.discount.toString()),
      'price_without_tax': double.parse(product.priceWithoutTax.toString()),
      'discount': double.parse(product.discount.toString()),
      'average_rating':product.averageRate??"0",
      'cat_id':product.catID,
      'brand_id':product.brandID,
      'quantity':product.quantity,
      "attributes_des": product.attributesDes.toString(),
      "categories": json.encode(product.categoryList
          .map((item) => CategoriesModel.toJsonLocal(item))
          .toList()),
      "reviews":product.reviewsList==null || product.reviewsList!.isEmpty ? [] : json.encode(product.reviewsList
          ?.map((item) => ProductComments.toJsonLocal(item))
          .toList()),
       "discount_parents":product.discountParentProduct??[],   
    };
  }

  static getParentDiscountIDS(var jsonObject){
    List<String> list = [];
    if(jsonObject['discount_parents']!=null && jsonObject['discount_parents'].toString()!="[]"){
      for(var i in jsonObject['discount_parents']){
        list.add(i.toString());
      }
    }
    return list;
  }
}

