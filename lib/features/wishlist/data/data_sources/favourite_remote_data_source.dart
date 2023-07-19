import 'dart:convert';

import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

abstract class FavouriteRemoteDataSourceImpl{
  Future<List<ProductsEntity>> fetchAllFavourites();
  Future<bool> addFavouriteItem({required Map<String,dynamic> data});
  Future<bool> removeFavouriteItem({required int favID});
}


class FavouriteRemoteDataSource extends FavouriteRemoteDataSourceImpl{
  final http.Client client;
  FavouriteRemoteDataSource({required this.client});

  @override
  Future<bool> addFavouriteItem({required Map<String,dynamic> data}) async{
    var bodyData = {
      "product_ids": data['fav_list']
    };
    var response = await client.post(Uri.parse(ApiUrl.ADD_TO_FAV),body: jsonEncode(bodyData),headers: ApiUrl.headerAuth);
    debugPrint("addFavouriteItem ${response.body}");
    if (response.body.contains("done")) {
      final body = json.decode(response.body);
      return body.toString().contains("done") ? true : false;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> fetchAllFavourites() async{
    var response = await client.get(Uri.parse("${ApiUrl.GET_ALL_FAV}?offset=0&limit=100&sort[column]=name&sort[order]=asc"),headers: ApiUrl.headerAuth);
    debugPrint("fetchAllFavourites ${response.body}");
    if (response.body.contains("done")) {
      final body = json.decode(response.body);
      if(body['data']['data'].toString()=="[]")return [];
      return ProductModel.listModelFromJson(jsonEncode(body['data']['data'][0]['products']));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeFavouriteItem({required int favID}) async{
    var response = await client.delete(Uri.parse("${ApiUrl.REMOVE_FAV}$favID"),headers: ApiUrl.headerAuth);
    debugPrint("removeFavouriteItem ${response.body}");
    if (response.body.contains("done")) {
      final body = json.decode(response.body);
      return body.toString().contains("done") ? true : false;
    } else {
      throw ServerException();
    }
  }

}