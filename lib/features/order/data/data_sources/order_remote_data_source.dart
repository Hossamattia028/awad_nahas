import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/set_notification.dart';
import 'package:awad_nahas/features/order/data/models/order_model.dart';


abstract class OrderRemoteDataSourceImpl {
  Future<List<OrderModel>> getAllOrder();
  Future<bool> addOrder({required Map<String,dynamic> data});
  Future<bool> updateOrder({required Map<String,dynamic> data,File? fileR});
  Future<bool> cancelOrder({required int orderId});
}

class OrderRemoteDataSource implements OrderRemoteDataSourceImpl {
  final http.Client client;
  OrderRemoteDataSource({required this.client});
  @override
  Future<List<OrderModel>> getAllOrder() async {
    var response = await client.get(Uri.parse(ApiUrl.FETCH_ALL_ORDERS), headers: ApiUrl.headerAuth);
    debugPrint("getAllOrder: ${response.body} \n ${ApiUrl.headerAuth}");
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
  Future<bool> addOrder({required Map<String,dynamic> data}) async {
    final response = await client.post(Uri.parse(ApiUrl.ADD_ORDER),
        body: json.encode(data),
        headers: ApiUrl.headerAuth);
     debugPrint("addOrder: ${response.body}");
     var decodedData = jsonDecode(response.body);
    if (decodedData['status']==true) {
      SetNotification.showNotification(title: "", msg: translate("toast.order_send"));
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateOrder({required Map<String,dynamic> data,File? fileR}) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.STORAGE_URL));
    var headers = ApiUrl.headerAuth;
    if(data['delivery_status']!=null)request.fields['delivery_status'] = data['delivery_status'].toString();
    if(data['order_id']!=null)request.fields['order_id'] = data['order_id'].toString();
    if(fileR!=null){
      var file = await http.MultipartFile.fromPath('attachment_confirmed_file', fileR.path);
      request.files.add(file);
    }
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
     debugPrint("updateOrder: ${res.body}");
    if (res.body.toString().contains("true")) {
      // SetNotification.showNotification(title: "", msg: translate("toast.update_user_data"));
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



}
