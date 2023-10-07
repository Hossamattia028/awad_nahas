import 'dart:convert';

import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

abstract class FavouriteRemoteDataSourceImpl{
  Future<List<ProductsEntity>> fetchAllFavourites();
  Future<bool> addFavouriteItem({required Map<String,dynamic> data});
  Future<bool> removeFavouriteItem({required Map<String,dynamic> data});
}


class FavouriteRemoteDataSource extends FavouriteRemoteDataSourceImpl{
  final http.Client client;
  FavouriteRemoteDataSource({required this.client});

  @override
  Future<bool> addFavouriteItem({required Map<String,dynamic> data}) async{
    var response = await client.post(Uri.parse("${ApiUrl.ADD_TO_FAV}${Util.getUserID()}/${data['product_id']}"),headers: ApiUrl.headerAuth);
    // debugPrint("addFavouriteItem ${response.body}");
    if (response.body.contains("true")) {
      final body = json.decode(response.body);
      return body.toString().contains("done") ? true : false;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> fetchAllFavourites() async{
    var response = await client.get(Uri.parse("${ApiUrl.GET_ALL_FAV}${Util.getUserID()}"),headers: ApiUrl.headerAuth);
    // debugPrint("fetchAllFavourites ${response.body}");
    if (response.body.contains("true")) {
      final body = json.decode(response.body);
      if(body['data'].toString()=="[]")return [];
      return ProductModel.listModelFromJson(jsonEncode(body['data']));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeFavouriteItem({required Map<String,dynamic> data}) async{
    var response = await client.post(Uri.parse("${ApiUrl.ADD_TO_FAV}${Util.getUserID()}/${data['product_id']}"),headers: ApiUrl.headerAuth);
    // debugPrint("addFavouriteItem ${response.body}");
    if (response.body.contains("true")) {
      final body = json.decode(response.body);
      return body.toString().contains("done") ? true : false;
    } else {
      throw ServerException();
    }
  }

}