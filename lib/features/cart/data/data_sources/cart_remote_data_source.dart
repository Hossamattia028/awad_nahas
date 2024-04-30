import 'dart:convert';

import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/data/models/cart_model.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';

abstract class CartRemoteDataSourceImpl{
  Future<CartModel> fetchAllCartList();
  Future<bool> addCartItem({required Map<String,dynamic> data});
  Future<bool> removeCartItem({required int productID});
  Future<ResCouponModel> applyCoupon({required Map<String,dynamic> dataSet});
}


class CartRemoteDataSource extends CartRemoteDataSourceImpl{
  final http.Client client;
  CartRemoteDataSource({required this.client});

  @override
  Future<bool> addCartItem({required Map<String,dynamic> data}) async{
    var response = await client.post(Uri.parse("${ApiUrl.ADD_TO_CART}${Util.getUserID()}"),body: jsonEncode(data),headers: ApiUrl.headerAuth);
    // debugPrint("addOrUpdateCartItem ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if(body['status']){
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
    var response = await client.get(Uri.parse("${ApiUrl.GET_ALL_CART}${Util.getUserID()}"),headers: ApiUrl.headerAuth);
    // debugPrint("fetchAllCartList ${response.body}");
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if(decodedData['status']){
        return CartModel.fromJson(decodedData['data']);
      }
      throw ServerException();
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
  Future<ResCouponModel> applyCoupon({required Map<String,dynamic> dataSet}) async{
    var response = await http.post(Uri.parse(ApiUrl.coupon),
        headers: ApiUrl.headerAuth,body: jsonEncode(dataSet));
    debugPrint("applyCoupon ${response.body}");
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if(body['status']) {
        return ResCouponModel(couponModel: CouponModel(
            total: 0,
            code: body['coupon']['code'].toString(),
            amount: int.parse(body['coupon']['amount'].toString()),
            isPercent: body['coupon']['is_percent']??false),msg: "",status: true);
      }else{
        String msg = translate("cart.couponـwrong");
        if(body['message'].toString().contains("user not authorized"))msg = translate("toast.coupon_user_not_registered");
        if(body['message'].toString().contains("coupon used before for this user"))msg = translate("toast.coupon_duplicated");
        if(body['message'].toString().contains("coupon just for new users"))msg = translate("toast.coupon_just_for_new_users");
        return ResCouponModel(
          couponModel: CouponModel(total: 0,code: "",amount: 0,isPercent: false),
          msg: msg,
          status: false);
      }
    } else {
      throw ServerException();
    }
  }

}