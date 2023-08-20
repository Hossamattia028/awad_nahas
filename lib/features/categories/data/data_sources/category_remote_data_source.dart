import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/categories/data/models/slider_model.dart';

abstract class CategoryRemoteDataSourceImpl {
  Future<List<CategoriesModel>> getAllCategory();
  Future<List<CategoriesModel>> getAllBrands();
  Future<SliderModel> getAllSliders({required String sliderTitle});
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
        return CategoriesModel.fromJson(categoryModel);
      }).toList();
      return categories;
      // return categories.where((element) => (!element.imgPath.toString().contains("{s:")) && element.imgPath.toString().trim()!="").toList();
    } else {
      throw ServerException();
    }
  }


  @override
  Future<SliderModel> getAllSliders({required String sliderTitle}) async{
    var response = await client.get(Uri.parse("${ApiUrl.SLIDERS_URL}?offset=0&limit=100&sort[column]=name&sort[order]=asc&fields[post_title][value]=$sliderTitle"));
    // debugPrint("getAllSliders-$sliderTitle: ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if(body['data']['data'].toString()=="[]")return const SliderModel(title: "null", images: [], id: 0);
      return SliderModel.fromJson(body['data']['data'][0]);
    } else {
      throw ServerException();
    }
  }


}
