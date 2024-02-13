import 'dart:convert';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/data/models/product_model.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';

abstract class ProductsRemoteDataSourceImpl {
  Future<ProductResponseModel> getAllProducts({required String parameter});
  Future<List<ProductComments>> getAllProductComments({required Map<String,dynamic> data});
  Future<bool> addProductComment({required Map<String,dynamic> data});
}

class ProductsRemoteDataSource implements ProductsRemoteDataSourceImpl {
  final http.Client client;
  ProductsRemoteDataSource({required this.client});

  @override
  Future<ProductResponseModel> getAllProducts({required String parameter}) async {
    var response = await client.get(Uri.parse("${ApiUrl.PRODUCTS_URL}/$parameter"));
    // debugPrint("getAllProducts ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<ProductModel> products =
          body['data'].map<ProductModel>((model) {
        return ProductModel.fromJson(model);
      }).toList();
      return ProductResponseModel(products: products, productsCount: int.tryParse(body['count'].toString())!=null ? int.parse(body['count'].toString()) : 0);
    } else {
      throw ServerException();
    }
  }


  static Future<String> getProductDetails({required int id}) async {
    try{
      var response = await http.get(Uri.parse("${ApiUrl.BASE_URL_ABN_PLUGIN}products/$id?lang=${Util.getLang()=="ar"?"ar":"en"}"));
      // debugPrint("getProductDetails ${response.body}");
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body['description'];
      } else {
        throw ServerException();
      }
    }catch(e){
      throw ServerException();
    }
  }

  @override
  Future<List<ProductComments>> getAllProductComments({required Map<String,dynamic> data}) async {
    var response = await client.get(Uri.parse("${ApiUrl.COMMENTS_URL}?offset=0&limit=100&sort[column]=name&sort[order]=asc&fields[comment_post_ID][value]=${data['product_id']}"));
    // debugPrint("getAllProductComments ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<ProductComments> products =
      body['data']['data'].map<ProductComments>((model) {
        return ProductComments.fromJson(model);
      }).toList();
      return products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> addProductComment({required Map<String,dynamic> data}) async {
    var response = await client.post(Uri.parse(ApiUrl.COMMENTS_URL),
        body: jsonEncode(data),
        headers: ApiUrl.headerAuth);
    // debugPrint("addProductComment ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['status'] ?? false;
    } else {
      throw ServerException();
    }
  }




}
