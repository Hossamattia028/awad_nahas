import 'dart:convert';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/categories/data/models/slider_model.dart';

abstract class CategoryRemoteDataSourceImpl {
  Future<List<CategoriesModel>> getAllCategory();
  Future<List<CategoriesModel>> getAllBrands();
  Future<List<SliderModel>> getAllSliders();
}

class CategoryRemoteDataSource implements CategoryRemoteDataSourceImpl {
  final http.Client client;
  CategoryRemoteDataSource({required this.client});
  @override
  Future<List<CategoriesModel>> getAllCategory() async {
    var response = await client.get(Uri.parse(ApiUrl.CATEGORIES_URL));
    // debugPrint("getAllCategory ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<CategoriesModel> categories =
          body['data'].map<CategoriesModel>((categoryModel) {
        return CategoriesModel.fromJson(categoryModel);
      }).toList();
      return categories;
      // return categories.where((element) => (!element.imgPath.toString().contains("{s:")) && element.imgPath.toString().trim()!="").toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoriesModel>> getAllBrands() async {
    var response = await client.get(Uri.parse(ApiUrl.BRANDS_URL));
    // debugPrint("getAllBrands ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<CategoriesModel> categories =
          body['data'].map<CategoriesModel>((categoryModel) {
        return CategoriesModel.fromBrandJson(categoryModel);
      }).toList();
      return categories;
      // return categories.where((element) => (!element.imgPath.toString().contains("{s:")) && element.imgPath.toString().trim()!="").toList();
    } else {
      throw ServerException();
    }
  }


  @override
  Future<List<SliderModel>> getAllSliders() async{
    var response = await client.get(Uri.parse(ApiUrl.SLIDERS_URL));
    debugPrint("getAllSliders: ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<SliderModel> sliders =
      body['data'].map<SliderModel>((model) {
        return SliderModel.fromJson(model);
      }).toList();
      return sliders;
    } else {
      throw ServerException();
    }
  }

  static Future<String> getBrandDesc({required String id}) async{
    id = id.replaceAll("-ar", "").replaceAll("-en", "").replaceAll("-en_US", "");
    var response = await http.get(Uri.parse("https://demo.awadnahas.com/wp-json/inetwork/api/brand/$id?lang=${Util.getLang()=="ar"?"ar":"en_US"}"));
    debugPrint("getBrandDesc ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['description'];
    } else {
      throw ServerException();
    }
  }


}
