

import 'dart:convert';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';

class OrderModel extends Orders {
  const OrderModel({
    super.items,
    super.orderId,
    super.code,
    super.userId,
    super.userName,
    super.userPhone,
    super.userEmail,
    super.userCountry,
    super.userCity,
    super.userState,
    super.managerId,
    super.driverID,
    super.driverName,
    super.desc,
    super.area,
    super.city,
    super.shippingAddress,
    super.addressId,
    super.status,
    super.statusView,
    super.type,
    super.price,
    super.discount,
    super.couponDiscount,
    super.deliveryPrice,
    super.packagesPrice,
    super.totalPrice,
    super.deposit,
    super.isDeposit,
    super.deliveryMethod,
    super.paymentMethod,
    super.lat,
    super.lng,
    super.date,
    super.file,
  });

  static OrderModel fromJson(Map<String, dynamic> jsonObject) {
    return OrderModel(
        orderId: int.parse(jsonObject['ID']??"0"),
        code: int.parse(jsonObject['ID']??"0"),
        desc: jsonObject['post_title'],
        status: jsonObject['post_status'],
        statusView: getStatus(jsonObject['post_status']),
        date: jsonObject['post_date']??"",
        city: jsonObject['city']??"",
        userId: jsonObject['customer_id']??"",
        userName: jsonObject['customer_name']??"",
        driverID: int.parse(jsonObject['driver_id']??"0"),
        managerId: int.parse((jsonObject['manager_id'] ?? "0").toString()),
        driverName: jsonObject['driver_name']??"",
        userPhone: jsonObject['customer_phone']??"",
        userEmail: jsonObject['customer_email']??"",
        userCity: jsonObject['customer_city']??"",
        userCountry: jsonObject['customer_country']??"",
        userState: jsonObject['customer_state']??"",
        totalPrice:  double.parse((jsonObject['total_price']??"0.0").toString()),
        items:OrderItem.listFromJson(jsonEncode(jsonObject['itemsO']??"[]")),
        file: jsonObject['attachment_confirmed_file']!=null && jsonObject['attachment_confirmed_file']!=""?"${ApiUrl.STORAGE_URL}${jsonObject['attachment_confirmed_file']}":"",
    );
  }


  static getStatus(String val){
    if(val=="wc-processing" || val == "PENDING"){
      return translate("order.pending");
    }else if(val=="wc-on-hold" || val == "ASSIGNED"){
      return translate("order.assigned");
    }else if(val=="wc-completed" || val == "COMPLETED" || val == "DELIVERED"){
      return translate("order.order_has_done");
    }
    return val;
  }

  static getStatusViewCheck(String val){
    if(val=="wc-processing" || val == "PENDING" ){
      return ORDER_STATUS.PENDING;
    }else if(val=="wc-on-hold" || val == "ASSIGNED"){
      return ORDER_STATUS.ASSIGNED;
    }else if(val=="wc-completed" || val == "COMPLETED" || val == "DELIVERED"){
      return ORDER_STATUS.DELIVERED;
    }
    return ORDER_STATUS.PENDING;
  }


}
