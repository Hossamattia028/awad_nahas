import 'dart:convert';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/order/data/models/order_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/set_notification.dart';
import 'package:awad_nahas/features/order/data/models/order_model.dart';


abstract class OrderRemoteDataSourceImpl {
  Future<List<OrderModel>> getAllOrder();
  Future<OrderResponse> addOrder({required Map<String,dynamic> data});
  Future<bool> updateOrder({required Map<String,dynamic> data});
  Future<bool> cancelOrder({required int orderId});
}

class OrderRemoteDataSource implements OrderRemoteDataSourceImpl {
  final http.Client client;
  OrderRemoteDataSource({required this.client});
  @override
  Future<List<OrderModel>> getAllOrder() async {
    var response = await client.get(Uri.parse(ApiUrl.FETCH_ALL_ORDERS), headers: ApiUrl.headerAuth);
    // debugPrint("getAllOrder: ${response.body}");
    final decodedData = json.decode(response.body);
    if (decodedData['status']) {
      List<OrderModel> orders = decodedData['data'].map<OrderModel>((orderModel) {
        return OrderModel.fromJson(orderModel);
      }).toList();
      return orders;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderResponse> addOrder({required Map<String,dynamic> data}) async {
    String? orderID = SharedPref().getPreferenceString(Constants.pendingOrder);
    if(orderID!="")data['order_id']=orderID;
    data['is_update']="true";
    final response = await client.post(Uri.parse(ApiUrl.ADD_ORDER),
        body: json.encode(data),
        headers: ApiUrl.headerAuth);
    debugPrint("addOrder: ${response.body} ${data.values.toString()} ${data['status'].toString()}");
    var decodedData = jsonDecode(response.body);
    if (decodedData['status']==true) {
      if(decodedData['order_id']!=null)SharedPref().setPreferencesString(Constants.pendingOrder, decodedData['order_id'].toString().trim());
      if(data['status']==WCStatusKey.wc_processing){
        SharedPref().removePreference(Constants.pendingOrder);
        SetNotification.showNotification(title: "", msg: translate("toast.order_send"));
      }
      return OrderResponse(state: true, msg: data['message'], orderID: decodedData['order_id'].toString());
    } else {
      return OrderResponse(state: false, msg: data['message'], orderID: "-1");
    }
  }

  @override
  Future<bool> updateOrder({required Map<String,dynamic> data}) async {
    String? orderID = SharedPref().getPreferenceString(Constants.pendingOrder);
    if(orderID=="")return false;
    var request = http.MultipartRequest('POST', Uri.parse("${ApiUrl.UPDATE_ORDER_STATUS}/$orderID/${data['status']}"));
    var headers = ApiUrl.headerAuth;
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
     debugPrint("updateOrder: ${res.body}");
    var decodedData = jsonDecode(res.body);
    if (decodedData['status']) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> cancelOrder({required int orderId}) async {
    final response = await client.delete(
        Uri.parse(ApiUrl.CANCEL_ORDER),
        headers: ApiUrl.headerAuth,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }


  static Future<bool> trackOrder({required Map<String,dynamic> data}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.TRACK_ORDER));
      var headers = ApiUrl.headerAuth;
      request.headers.addAll(headers);
      if(data['order_data']!=null)request.fields['order_data'] = data['order_data'];
      var streamedResponse = await request.send();
      var res = await http.Response.fromStream(streamedResponse);
      debugPrint("trackOrder: ${res.body}");
      if (res.body.toString().toLowerCase().contains("successfully")) {
        return true;
      } else {
        throw ServerException();
      }
    }catch(e){
       debugPrint("trackOrderError: $e");
       return false;
    }
  }
}
