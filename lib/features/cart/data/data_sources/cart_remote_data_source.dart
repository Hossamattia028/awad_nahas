import 'dart:convert';

import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/data/models/cart_model.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';

abstract class CartRemoteDataSourceImpl{
  Future<CartModel> fetchAllCartList();
  Future<bool> addCartItem({required Map<String,dynamic> data});
  Future<bool> removeCartItem({required int productID});
  Future<CouponModel> applyCoupon({required Map<String,dynamic> dataSet});
}


class CartRemoteDataSource extends CartRemoteDataSourceImpl{
  final http.Client client;
  CartRemoteDataSource({required this.client});

  @override
  Future<bool> addCartItem({required Map<String,dynamic> data}) async{
    var bodyData = {
      // "session_key": Util.getCartKey(),
      "session_value": data['session_value'],
    };
    var response = await client.post(Uri.parse(ApiUrl.ADD_TO_CART),body: jsonEncode(bodyData),headers: ApiUrl.headerAuth);
    debugPrint("addOrUpdateCartItem ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if(body['message'].toString().contains("done")){
        // SharedPref().setPreferencesString(Constants.myCartID, body['data']['session_id'].toString());
        return true;
      }
      return false;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CartModel> fetchAllCartList() async{
    var response = await client.get(Uri.parse("${ApiUrl.GET_ALL_CART}"),headers: ApiUrl.headerAuth);
    debugPrint("fetchAllCartList ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return CartModel.fromJson(body['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> removeCartItem({required int productID}) async{
    var response = await client.delete(Uri.parse("${ApiUrl.UPDATE_USER_PROFILE}$productID"),headers: ApiUrl.headerAuth);
    // debugPrint("removeFavouriteItem ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['status'] ?? false;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CouponModel> applyCoupon({required Map<String,dynamic> dataSet}) async{
    var data = {
      // "session_key": Util.getCartKey(),
      'coupon_name': dataSet['code'],
    };
    var response = await http.post(Uri.parse(ApiUrl.coupon),
        headers: ApiUrl.headerAuth,body: jsonEncode(data));
    debugPrint("applyCoupon ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if(body['message'].toString().contains("done") && !body['data'].toString().contains("coupon already added")) {
        return CouponModel(
            total: double.parse(body['data']['session_value']['cart_totals']['total'].toString()).toDouble(),
            code: body['data']['session_value']['applied_coupons'][0]??"",
            amount: int.parse(body['data']['session_value']['coupon_discount_totals']['${dataSet['code']}'].toString()),
            isPercent: false);
      }else{
        return CouponModel(total: 0,code: "",amount: 0,isPercent: false);
      }
      //test-coupon
    } else {
      throw ServerException();
    }
  }

}